import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/enums/room.dart';
import 'package:freshswipe/ui/widgets/global/level_star.dart';

class CleaningPage extends StatefulWidget {
  final String roomName;
  final String selectedHousingName;
  final String selectedHousingId;

  const CleaningPage(
      {super.key,
      required this.roomName,
      required this.selectedHousingName,
      required this.selectedHousingId});

  @override
  State<StatefulWidget> createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  //Define the variables
  late Future<void> _fetchRoomTypeFuture;
  RoomType? roomType;
  List<bool> isCompletedList = [];
  List<DateTime> lastCompletedList = [];
  final int cooldownMinutes = 1;

  //Initialisation of the page
  @override
  void initState() {
    super.initState();
    _fetchRoomTypeFuture = _fetchRoomType();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // FutureBuilder, which is used to fetch room data for later use.
        body: FutureBuilder<void>(
            future: _fetchRoomTypeFuture,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return _buildContent();
              }
            }));
  }

  //Building page content
  Widget _buildContent() {
    const Key centerKey = ValueKey<String>('sliver-list');
    if (roomType == null) {
      return const Center(child: Text('Room type not found.'));
    }
    return Center(
        child: FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Column(
        children: [
          LevelStar(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 3, 72, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.roomName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              child: CustomScrollView(
            center: centerKey,
            slivers: [
              SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (roomType == null ||
                        index >= roomType!.roomTypeToOperations.length) {
                      return const SizedBox.shrink();
                    }

                    final operation = roomType!.roomTypeToOperations[index];
                    final bool isCompleted = isCompletedList[index];
                    final lastCompleted = lastCompletedList[index];
                    final canComplete =
                        DateTime.now().difference(lastCompleted).inMinutes >=
                            cooldownMinutes;

                    return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity! > 0 && canComplete && !isCompletedList[index]) {
                            setState(() {
                              isCompletedList[index] = true;
                              _addPointsToRoom(operation.points, index);
                            });
                          }
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (!isCompleted && canComplete)
                                  ? const Color.fromARGB(255, 188, 188, 188)
                                  : const Color.fromRGBO(0, 3, 72, 1)),
                          child: Center(
                              child: Text(
                            operation.label,
                            style: TextStyle(
                                color: (!isCompleted && canComplete)
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : Colors.white),
                          )),
                        ));
                  },
                  childCount: roomType?.roomTypeToOperations.length ?? 0,
                ),
              ),
            ],
          ))
        ],
      ),
    ));
  }

  


  //A method of adding points to a specific room.
  Future<void> _addPointsToRoom(int points, int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        //Get a snapshot of room information.
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(widget.selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: widget.roomName)
            .get();

        //Specifies the current ID of the room.
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot roomSnapshot = querySnapshot.docs.first;
          String roomId = roomSnapshot.id;

          // Fetch the room reference information.
          DocumentReference roomRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('housings')
              .doc(widget.selectedHousingId)
              .collection('rooms')
              .doc(roomId);

            DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

            await FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot userSnapshot = await transaction.get(userRef);
              if (userSnapshot.exists) {
                int currentActivities = userSnapshot['cleaningActivities'] ?? 0;

                //Initialize new points for user's total points.
                int currentPoints = userSnapshot['userCleaningPoints'] ?? 0;
                int updatedPoints = currentPoints + points;

                // Send data to the database with updated amount of cleaning activities, users total points and last activity timestamp.
                transaction.update(userRef, {'cleaningActivities': currentActivities + 1, 'userCleaningPoints': updatedPoints, 'latestActivity': Timestamp.now()});
              }
            });
            

          // Update the new value of the points in the database.
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot roomSnapshot = await transaction.get(roomRef);
            if (roomSnapshot.exists) {
              int currentPoints = roomSnapshot['roomPoints'] ?? 0;
              int updatedPoints = currentPoints + points;
              transaction
                  .update(roomRef, {'roomPoints': updatedPoints});
              if (kDebugMode) {
                print('Points updated to $updatedPoints');
              }
            }
          });

          //Update the new task completion time in the database.
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot roomSnapshot = await transaction.get(roomRef);
            if (roomSnapshot.exists) {
              List<Map<String, dynamic>> operations =
                  List.from(roomSnapshot['operations']);
              operations[index]['lastCompleted'] =
                  Timestamp.fromDate(DateTime.now());
              transaction.update(roomRef, {'operations': operations});
            }
          });

          
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error adding points to the room: $e');
        }
      }
    }
  }

  //A method for adding new tasks when no previous data has been found.
  Future<void> _addOperationsToRoom() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        //Get a snapshot of room information.
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(widget.selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: widget.roomName)
            .get();

        //Specifies the current ID of the room.
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot roomSnapshot = querySnapshot.docs.first;
          String roomId = roomSnapshot.id;

          // Fetch the room reference information.
          DocumentReference roomRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('housings')
              .doc(widget.selectedHousingId)
              .collection('rooms')
              .doc(roomId);

          //Add new task completion times to the database.
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot roomSnapshot = await transaction.get(roomRef);
            if (roomSnapshot.exists) {
              List<Map<String, dynamic>> operations = [];
              for (var i = 0; i < roomType!.roomTypeToOperations.length; i++) {
                operations
                    .add({'lastCompleted': Timestamp.fromDate(DateTime(1970))});
              }

              // Send updated list of timestamps for all operations.
              transaction.update(roomRef, {'operations': operations});

              if (kDebugMode) {
                print('Operations added!');
              }
            }
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print(
              'Error in adding the last completion list to the database.: $e');
        }
      }
    }
  }

  //Load the room type and check if there are previous completion times for the already initialised tasks.
  Future<void> _fetchRoomType() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        //Get a snapshot of room information.
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(widget.selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: widget.roomName)
            .get();

        //Define a snapshot of the room using the first found name of the room.
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot roomSnapshot = querySnapshot.docs.first;

          //Fetches the current type of room.
          if (roomSnapshot.exists) {
            String roomTypeString = roomSnapshot['roomType'];
            roomType = RoomType.values
                .firstWhere((e) => e.toString() == roomTypeString);

            //Synchronizes database values with local variables.
            if (roomType != null) {
              int numOfOperation = roomType!.roomTypeToOperations.length;
              setState(() {
                isCompletedList = List<bool>.filled(numOfOperation, false);
                lastCompletedList = List<DateTime>.filled(
                    numOfOperation, DateTime.fromMicrosecondsSinceEpoch(0));
              });

              //Checks if there is already completion time data available and synchronizes them with local variables.
              if ((roomSnapshot.data() as Map<String, dynamic>)
                  .containsKey('operations')) {
                List<dynamic> operationsData = roomSnapshot['operations'];
                List<DateTime> lastCompletedData = List<DateTime>.from(
                    operationsData.map(
                        (operation) => operation['lastCompleted'].toDate()));

                setState(() {
                  lastCompletedList = lastCompletedData;
                });

                // If no data is available, the _addOperationsToRoom method creates new values in the database.
              } else {
                _addOperationsToRoom();
              }
            }
          }
        } else {
          throw Exception('Room not found.');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fething room type: $e');
        }
      }
    }
  }
}

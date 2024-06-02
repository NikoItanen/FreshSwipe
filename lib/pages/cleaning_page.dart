import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/enums/room.dart';
import 'package:freshswipe/widgets/global/cleanliness_star.dart';

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
  late Future<void> _fetchRoomTypeFuture;
  RoomType? roomType;

  @override
  void initState() {
    super.initState();
    _fetchRoomTypeFuture = _fetchRoomType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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

  Widget _buildContent() {
    const Key centerKey = ValueKey<String>('sliver-list');
    return Center(
        child: FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Column(
        children: [
          const TotalCleanlinessStar(),
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
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.selectedHousingId,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        roomType!.label,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ],
              ),
              
            ),
          ),
          Expanded(child: CustomScrollView(
            center: centerKey,
            slivers: [
              SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Stack(children: [
                          Container(
                      height: 100,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromRGBO(0, 3, 72, 1)),
                        ),
                        Positioned.fill(child: TextButton(
                          child: Text(roomType!.roomTypeToOperations[index].label, style: const TextStyle(color: Colors.white),),
                          onPressed: () {
                            if (kDebugMode) {
                            print('Cleaning operation pressed!');
                            }
                          },))
                        ],) 
                    ));
                  },
                  childCount: roomType!.roomTypeToOperations.length,
                ),
              ),
            ],
          ))
        ],
      ),
    ));
  }

  Future<void> _fetchRoomType() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(widget.selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: widget.roomName)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return querySnapshot.docs.first;
          } else {
            throw Exception('Room not found');
          }
        });

        if (roomSnapshot.exists) {
          String roomId = roomSnapshot.id;
          DocumentSnapshot roomDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('housings')
              .doc(widget.selectedHousingId)
              .collection('rooms')
              .doc(roomId)
              .get();

          if (roomDoc.exists) {
            String roomTypeString = roomDoc['roomType'];
            roomType = RoomType.values
                .firstWhere((e) => e.toString() == roomTypeString);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fething room type: $e');
        }
      }
    }
  }
}

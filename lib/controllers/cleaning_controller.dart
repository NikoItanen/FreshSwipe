import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freshswipe/enums/rooms.dart';

class CleaningController {

  //A method of adding points to a specific room.
  static Future<void> addPointsToRoom(int points, int index, String selectedHousingId, String roomName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        //Get a snapshot of room information.
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: roomName)
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
              .doc(selectedHousingId)
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
  static Future<void> addOperationsToRoom(String selectedHousingId, String roomName, RoomType roomType) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        //Get a snapshot of room information.
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('housings')
            .doc(selectedHousingId)
            .collection('rooms')
            .where('roomName', isEqualTo: roomName)
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
              .doc(selectedHousingId)
              .collection('rooms')
              .doc(roomId);

          //Add new task completion times to the database.
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot roomSnapshot = await transaction.get(roomRef);
            if (roomSnapshot.exists) {
              List<Map<String, dynamic>> operations = [];
              for (var i = 0; i < roomType.roomTypeToOperations.length; i++) {
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
  
}
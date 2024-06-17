import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/models/housing.dart';
import 'package:freshswipe/models/room.dart';

class HousingController {
  // Fetches user's housings from database
  static Future<List<DropdownMenuItem<String>>> fetchHousingDropdownItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<DropdownMenuItem<String>> items = [];
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot housingQuery = await FirebaseFirestore.instance.collection('users').doc(userId).collection('housings').get();

      items = housingQuery.docs.map((doc) {
        return DropdownMenuItem<String>(value: doc.id, child: Text(doc['housingName']),
        );
      }).toList();
    }
    return items;
  }

  //Add a room to the database.
  static Future<void> onAddRoom(String selectedHousingId, String roomName, String roomType) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        Room room = Room(
          id: '',
          roomName: roomName,
          roomType: roomType,
          housingId: selectedHousingId,
        );

        await FirebaseFirestore.instance.collection('users').doc(userId).collection('housings').doc(selectedHousingId).collection('rooms').add(room.toMap());

        if (kDebugMode) {
          print('Room added to Firestore!');
        }
      } else {
        if (kDebugMode) {
          print('No user logged in!');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error adding room: $e');
        print(stackTrace);
      }
    }
  }

  // Add housing to the database.
  static Future<void> onAddHousing(String housingName, bool isChecked) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        Housing housing = Housing(
          id: '',
          housingName: housingName,
          isMainHousing: isChecked,
          timestamp: Timestamp.now(),
        );

        await FirebaseFirestore.instance.collection('users').doc(userId).collection('housings').add(housing.toMap());

        if (kDebugMode) {
          print('Housing added to Firestore!');
        }
      } else {
        if (kDebugMode) {
          print('No user logged in!');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error adding housing: $e');
        print(stackTrace);
      }
    }
  }
}
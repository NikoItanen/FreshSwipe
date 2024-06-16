import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String id;
  final String roomName;
  final String roomType;
  final String housingId;

  Room({
    required this.id,
    required this.roomName,
    required this.roomType,
    required this.housingId,
  });

  factory Room.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Room(
      id: doc.id,
      roomName: data['roomName'],
      roomType: data['roomType'],
      housingId: data['housingId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'roomType': roomType,
      'housingId': housingId,
    };
  }

  
}
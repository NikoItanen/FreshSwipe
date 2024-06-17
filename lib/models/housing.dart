import 'package:cloud_firestore/cloud_firestore.dart';

class Housing {
  final String id;
  final String housingName;
  final bool isMainHousing;
  final Timestamp timestamp;

  Housing({
    required this.id,
    required this.housingName,
    required this.isMainHousing,
    required this.timestamp,
  });

  factory Housing.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Housing(
      id: doc.id,
      housingName: data['housingName'],
      isMainHousing: data['isMainHousing'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'housingName': housingName,
      'isMainHousing': isMainHousing,
      'timestamp': timestamp,
    };
  }

  
}
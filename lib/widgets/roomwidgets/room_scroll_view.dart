import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This class takes responsibility for the room listing. 

class RoomScrollView extends StatefulWidget {
  const RoomScrollView({super.key});

  @override
  State<StatefulWidget> createState() => _RoomScrollView();
}

class _RoomScrollView extends State<RoomScrollView> {

  List<String> roomItems = [];
  String? selectedHousingId;
  List<DropdownMenuItem<String>> housingDropdownItems = [];
  bool roomAdded = false;
  int cCode = 0;

  @override
  void initState() {
    super.initState();
    _fetchHousingDropdownItems();
    _fetchRoomItems();
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('sliver-list');
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(children: [
        _housingSelection(context, setState),
        roomItems.isEmpty 
        ? const Center(child: Text('You don\'t have rooms yet! Add a new one by pressing the "+" button.')) 
        : Expanded(child: CustomScrollView(
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
                      child: Text(roomItems[index], style: const TextStyle(color: Colors.white),),
                      onPressed: () {
                      if (kDebugMode) {
                        print('Room ${roomItems[index]} is pressed!');
                      }},))
                    ],) 
                ));
              },
              childCount: roomItems.length,
            ),
          ),
        ],
      ))
      ],) 
    );
  }

  Future<void> _fetchRoomItems () async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot roomsQuery = await FirebaseFirestore.instance.collection('users').doc(userId).collection('housings').doc(selectedHousingId).collection('rooms').get(
      );

      List<String> rooms = roomsQuery.docs.map((doc) {
        return doc['roomName'] as String;
      }).toList();

      setState(() {
        roomItems = rooms;
      });
    }
  }

  Widget _housingSelection(BuildContext context, StateSetter setState) {
    return Padding(padding: const EdgeInsets.only(left: 20, right: 20),
            child: DropdownButton<String>(
              hint: const Text('Select Housing'),
              value: selectedHousingId,
              
              onChanged: (String? newValue) {
                setState(() {
                  selectedHousingId = newValue!;
                  _fetchRoomItems();
                });
              },
              items: housingDropdownItems,
            ),
            );
  }

  // Fetches user's housings from database
  Future<void> _fetchHousingDropdownItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot housingQuery = await FirebaseFirestore.instance.collection('users').doc(userId).collection('housings').get();

      List<DropdownMenuItem<String>> items = housingQuery.docs.map((doc) {
        return DropdownMenuItem<String>(value: doc.id, child: Text(doc['housingName']),
        );
      }).toList();

      setState(() {
        housingDropdownItems = items;
        if (items.isNotEmpty) {
          selectedHousingId = items.first.value;
          _fetchRoomItems();
        }
      });
    }
  }

}

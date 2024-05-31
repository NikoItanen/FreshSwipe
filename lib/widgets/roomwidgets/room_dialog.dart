import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/enums/room.dart';

// This dialog takes responsibility for a new room, house, or apartment creation.
class RoomDialog extends StatefulWidget {
  const RoomDialog({super.key});
  // final VoidCallback onAddRoom;
  @override
  RoomDialogState createState() => RoomDialogState();
}

class RoomDialogState extends State<RoomDialog> {
  bool roomMode = true;
  final TextEditingController roomTypeController = TextEditingController();
  RoomType? selectedRoomType;

  Widget _dialogModeSwitchButtons(StateSetter setState) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              color: !roomMode ? Colors.grey[400] : Colors.grey[600],
              height: 40,
              width: 200,
            ),
            TextButton(
                child: const Text('Add A New Room',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    roomMode = true;
                  });
                })
          ],
        ),
        Stack(
          children: [
            Container(
              color: roomMode ? Colors.grey[400] : Colors.grey[600],
              height: 40,
              width: 200,
            ),
            TextButton(
                child: const Text('Add An Apartment',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    roomMode = false;
                  });
                })
          ],
        )
      ],
    );
  }

  Widget _roomInputsField(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(hintText: 'Room Name:'),
            )),
            const SizedBox(height: 20,),
            Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: DropdownMenu<RoomType>(
              controller: roomTypeController,
              menuHeight: 250,
              width: 400,
              enableFilter: true,
              requestFocusOnTap: true,
              leadingIcon: const Icon(Icons.search),
              label: const Text('Room Type'),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 5.0)
              ),
              onSelected: (RoomType? room) {
                setState(() {
                  selectedRoomType = room;
                });
              },
              dropdownMenuEntries: [
                ...RoomType.values.map<DropdownMenuEntry<RoomType>>(
                  (RoomType room) {
                    return DropdownMenuEntry<RoomType>(
                      value: room,
                      label: room.label,
                      leadingIcon: Icon(room.icon),
                      );
                  }
                  ),
              ],
            )
            ),
            const SizedBox(height: 20,),
            const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(hintText: 'Room Name:'),
            )),
        TextButton(
            child: const Text('Add Room'),
            onPressed: () {
              onAddRoom();
              Navigator.pop(context);
            }),
      ],
    );
  }

  void onAddRoom() {
    if (kDebugMode) {
      print('Room added pressed!');
    }
  }

  void onAddApartment() {
    if (kDebugMode) {
      print('Appartment added pressed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Dialog(
                              alignment: Alignment.center,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 500,
                                  width: 450,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('Housing Manager'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(alignment: Alignment.center, child: _dialogModeSwitchButtons(setState)),
                                      const SizedBox(height: 20,),
                                      _roomInputsField(context)
                                    ],
                                  )))));
            }));
  }
}

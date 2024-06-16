import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/controllers/housing_controller.dart';
import 'package:freshswipe/enums/room.dart';

// This dialog takes responsibility for a new room, house, or housing creation.
class RoomDialog extends StatefulWidget {
  const RoomDialog({super.key});
  @override
  RoomDialogState createState() => RoomDialogState();
}

class RoomDialogState extends State<RoomDialog> {
  bool roomMode = true;
  RoomType? selectedRoomType;
  final TextEditingController roomTypeController = TextEditingController();
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController housingNameController = TextEditingController();
  bool isChecked = false;
  String? selectedHousingId;
  List<DropdownMenuItem<String>> housingDropdownItems = [];

//Initialize dialog state
  @override
  void initState() {
    super.initState();
    _fetchHousingDropdownItems();
  }

  @override
  void dispose() {
    roomTypeController.dispose();
    roomNameController.dispose();
    super.dispose();
  }

  //Content build here:
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
                                      Align(
                                          alignment: Alignment.center,
                                          child: _dialogModeSwitchButtons(
                                              setState)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      roomMode
                                          ? _roomInputsField(context, setState)
                                          : _housingInputsField(
                                              context, setState)
                                    ],
                                  )))));
            }));
  }

//Creates buttons that take responsibility for changing the state of the dialog between creating a room and creating an housing.
  Widget _dialogModeSwitchButtons(StateSetter setState) {
    return Row(
      children: [
        Expanded(
            child: Stack(
          children: [
            Container(
              color: !roomMode ? Colors.grey[400] : Colors.grey[600],
              height: 40,
              width: 225,
            ),
            Center(
                child: TextButton(
                    child: const Text('Room',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        roomMode = true;
                      });
                    }))
          ],
        )),
        Expanded(
            child: Stack(
          children: [
            Container(
              color: roomMode ? Colors.grey[400] : Colors.grey[600],
              height: 40,
              width: 225,
            ),
            Center(
                child: TextButton(
                    child: const Text('Housing',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        roomMode = false;
                      });
                    }))
          ],
        ))
      ],
    );
  }

  Future<void> _fetchHousingDropdownItems() async {
    try {
      var items = await HousingController.fetchHousingDropdownItems();
      setState(() {
        housingDropdownItems = items;
        if (housingDropdownItems.isEmpty) {
          selectedHousingId = null;
        } else {
          selectedHousingId = housingDropdownItems.first.value;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching housing dropdown items: $e');
      }
    }
  }

//Creates an input field for the room creation state.
  Widget _roomInputsField(BuildContext context, StateSetter setState) {
    return Column(
      children: [
        FutureBuilder(
            future: HousingController.fetchHousingDropdownItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: housingDropdownItems.isEmpty
                        ? const Text('You have not added housings!')
                        : DropdownButton<String>(
                            hint: const Text('Select Housing'),
                            value: selectedHousingId ??
                                housingDropdownItems.first.value,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedHousingId = newValue;
                              });
                            },
                            items: housingDropdownItems.isNotEmpty
                                ? housingDropdownItems
                                : [
                                    const DropdownMenuItem(
                                        value: null,
                                        child: Text('No housing available!'))
                                  ],
                          ),
                  );
                }
              }
            }),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: roomNameController,
              decoration: const InputDecoration(hintText: 'Room Name:'),
            )),
        const SizedBox(height: 25),
        const SizedBox(height: 25),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownMenu<RoomType>(
              controller: roomTypeController,
              menuHeight: 250,
              enableFilter: true,
              requestFocusOnTap: true,
              leadingIcon: const Icon(Icons.search),
              label: const Text('Room Type'),
              inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
              onSelected: (RoomType? room) {
                setState(() {
                  selectedRoomType = room;
                });
              },
              dropdownMenuEntries: [
                ...RoomType.values
                    .map<DropdownMenuEntry<RoomType>>((RoomType room) {
                  return DropdownMenuEntry<RoomType>(
                    value: room,
                    label: room.label,
                    leadingIcon: Icon(room.icon),
                  );
                }),
              ],
            )),
        const SizedBox(
          height: 150,
        ),
        TextButton(
            child: const Text('Add Room'),
            onPressed: () {
              if (housingDropdownItems.isNotEmpty) {
                HousingController.onAddRoom(selectedHousingId!,
                    roomNameController.text, selectedRoomType.toString());
              }
              Navigator.pop(context);
            }),
      ],
    );
  }

//Creates an input field for the housing creation state.
  Widget _housingInputsField(BuildContext context, StateSetter setState) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: housingNameController,
              decoration: const InputDecoration(hintText: 'Housing name:'),
            )),
        const SizedBox(height: 25),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                const Text('Main Housing: '),
                Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    })
              ],
            )),
        const SizedBox(
          height: 240,
        ),
        TextButton(
            child: const Text('Add Housing'),
            onPressed: () async {
              HousingController.onAddHousing(
                  housingNameController.text, isChecked);
              Navigator.pop(context);
            }),
      ],
    );
  }
}

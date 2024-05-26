import 'package:flutter/material.dart';

class RoomDialog extends StatelessWidget {
  const RoomDialog({super.key});

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
                  builder: (BuildContext context) => Dialog(
                      alignment: Alignment.center,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 350,
                          width: 450,
                          child: Column(
                            children: [
                              Align(
                                  alignment: const Alignment(0.95, 0.9),
                                  child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })),
                              const TextField(
                                decoration:
                                    InputDecoration(hintText: 'Room Name: '),
                              )
                            ],
                          ))));
            }));
  }
}

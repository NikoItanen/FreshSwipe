import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This class takes responsibility for the room listing. 

class RoomScrollView extends StatefulWidget {
  final List<int> top;
  const RoomScrollView({required this.top, super.key});

  @override
  State<StatefulWidget> createState() => _RoomScrollView();
}

class _RoomScrollView extends State<RoomScrollView> {

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('sliver-list');
    List<int> top = widget.top;
    return Scaffold(
       backgroundColor: Colors.white,
      body: CustomScrollView(
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[200 + top[index] % 4 * 100]),
                    ),
                    Positioned.fill(child: TextButton(
                      child: Text('Room: ${top[index]}'),
                      onPressed: () {
                      if (kDebugMode) {
                        print('Room ${top[index]} is pressed!');
                      }},))
                    
                    ],) 
                ));
              },
              childCount: top.length,
            ),
          ),
        ],
      ),
    );
  }
}

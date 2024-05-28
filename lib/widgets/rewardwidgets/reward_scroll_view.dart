import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This class takes responsibility for the rewards listing. 

class RewardScrollView extends StatefulWidget {
  // final List<Reward> rewards;
  const RewardScrollView({super.key});

  @override
  State<StatefulWidget> createState() => _RewardScrollState();
}

class _RewardScrollState extends State<RewardScrollView> {

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('sliver-list');
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 3, 72, 1),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            key: centerKey,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(0, 3, 72, 1),
                  child: IconButton(icon: const Icon(Icons.emoji_events), color: index < 5 ? const Color.fromRGBO(255, 215, 70, 1) : Colors.blueGrey[200], iconSize: 40, onPressed: () {
                    if (kDebugMode) {
                      print('Reward ${index + 1} pressed!');
                    }
                  },)
                );
              }, childCount: 30
              )
          )
          ]
      ),
    );
  }
}

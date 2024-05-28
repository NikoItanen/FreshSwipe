import 'package:flutter/material.dart';
import 'package:freshswipe/models/reward.dart';

class RewardScrollView extends StatefulWidget {
  final List<Reward> rewards;
  const RewardScrollView({required this.rewards, super.key});

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
        center: centerKey,
        slivers: [
          SliverGrid.count(crossAxisCount: 4, children: const [
            Icon(Icons.emoji_events)
          ],)
        ],
      ),
    );
  }
}

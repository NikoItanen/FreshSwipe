import 'package:flutter/material.dart';
import 'package:freshswipe/controllers/reward_controller.dart';
import 'package:freshswipe/enums/rewards.dart';

//This class takes responsibility for the rewards listing. 

class RewardScrollView extends StatefulWidget {
  // final List<Reward> rewards;
  const RewardScrollView({super.key});

  @override
  State<StatefulWidget> createState() => _RewardScrollState();
}

class _RewardScrollState extends State<RewardScrollView> {

  //Initialise selected reward to the first item and 
  //create new list of user's unlocked rewards.
  Rewards? selectedReward = Rewards.values.first;
  List<String> unlockedRewards = [];

  @override
  void initState() {
    super.initState();
    _fetchUnlockedRewards();
  }

  //Content build here:
  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('sliver-list');
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 3, 72, 1),
      body: Column(children: [
        Text(
          selectedReward!.title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(selectedReward!.description,
          style:
          const TextStyle(color: Colors.white, fontSize: 14)
        ),
        Expanded(

          //Build scroll view box with Sliver Grid inside.
          child: CustomScrollView(
        slivers: [
          SliverGrid(
            key: centerKey,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final reward = _getRewardForIndex(index);
                final isUnlocked = unlockedRewards.contains(reward.name);
                return Container(
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(0, 3, 72, 1),
                  child: IconButton(
                    hoverColor: const Color.fromARGB(255, 0, 4, 107),
                    icon: Icon(reward.icon),
                    color: isUnlocked ? const Color.fromRGBO(255, 215, 70, 1) : Colors.blueGrey[200],
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        selectedReward = reward;
                      });
                  },)
                );
                //Amount of items to show.
              }, childCount: Rewards.values.length
              )
          )
          ]
      ),)
        
      ],) 
    );
  }

  Rewards _getRewardForIndex(int index) {
    return Rewards.values[index];
  }


Future<void> _fetchUnlockedRewards() async {
  List<String> rewards = await RewardController.getUnlockedRewards();
  setState(() {
    unlockedRewards = rewards;
  });
}
}
import 'package:flutter/material.dart';

class TotalCleanlinessStar extends StatelessWidget {
  double cleanlinessRate = 8.7;

  TotalCleanlinessStar({
    super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: SizedBox(
          width: 65,
          height: 65,
          child: Stack(
            children: <Widget>[
              const Icon(
                Icons.star,
                size: 65,
                color: Colors.orange,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Color.fromARGB(255, 36, 35, 0),
                    offset: Offset(0, 1))
                ],
              ),
              Center(child: Text(cleanlinessRate.toString()),)
            ],
          )
        )
      )
      );
  }
}
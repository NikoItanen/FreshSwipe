import 'package:flutter/material.dart';

class Reward {
  final String name;
  final String description;
  final int points;
  final Icon icon;

  Reward({
    required this.name,
    required this.description,
    required this.points,
    required this.icon
  });
}
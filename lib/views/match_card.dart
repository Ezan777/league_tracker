import 'package:flutter/material.dart';

import '../models/model.dart';

class MatchCard extends StatefulWidget {
  final Model model;

  const MatchCard({Key? key, required this.model}) : super(key: key);

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

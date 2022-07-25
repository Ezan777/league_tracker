import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class FullMatchInfo extends StatefulWidget {
  final Model model;
  final int index;

  const FullMatchInfo({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<FullMatchInfo> createState() => _FullMatchInfoState();
}

class _FullMatchInfoState extends State<FullMatchInfo> {
  Widget _buildParticipantInfoAt(int index) {
    final participant = index < 5
        ? (widget.model.summoner.allMatches[widget.index].blueSideTeam
            .participants()[index] as FinishedParticipant)
        : (widget.model.summoner.allMatches[widget.index].redSideTeam
            .participants()[index - 5] as FinishedParticipant);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(

                ),
                Text("${(participant.goldEarned / 1000).toStringAsFixed(1)} k"),
              ],
            ),
          )),
    );
  }

  Widget _buildMatchInfo() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildParticipantInfoAt(index),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("League Tracker"),
      ),
      body: _buildMatchInfo(),
    );
  }
}

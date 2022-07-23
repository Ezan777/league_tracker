import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/animated_shimmer/shimmer_loading.dart';

import '../models/model.dart';

class MatchCard extends StatefulWidget {
  final Model model;
  final int index;

  const MatchCard({Key? key, required this.model, required this.index}) : super(key: key);

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  Widget _buildCard() {
    if (!widget.model.buildingMatches.value) {
      if (widget.model.isSummonerInitialized) {
        final participant = (widget.model.summoner.allMatches[widget.index].participantFromSummoner(widget.model.summoner) as FinishedParticipant);
        final cardBackground = Image.asset("assets/images/centered_champions/${participant.championInfo["championName"]}_0.jpg");

        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: participant.isWinner ? Colors.green : Colors.red,
                width: 2,
              )
          ),
          child: Stack(
            children: [
              cardBackground,
              Positioned(
                child: Text(participant.isWinner ? "Win" : "Loss"),
              )
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return Container(
        width: 0.80 * MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(isLoading: widget.model.buildingMatches, child: _buildCard());
  }
}

import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/animated_shimmer/shimmer_loading.dart';

import '../models/model.dart';

class MatchCard extends StatefulWidget {
  final Model model;
  final int index;

  const MatchCard({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  Widget _buildCard() {
    if (!widget.model.buildingMatches.value) {
      if (widget.model.isSummonerInitialized) {
        final participant = (widget.model.summoner.allMatches[widget.index]
                .participantFromSummoner(widget.model.summoner)
            as FinishedParticipant);
        final cardBackground = Image.asset(
            "assets/images/centered_champions/${participant.championInfo["championName"]}_0.jpg");

        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: participant.isWinner ? Colors.green : Colors.red,
                width: 2,
              )),
          child: Stack(
            children: [
              cardBackground,
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  participant.isWinner ? "Win" : "Loss",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${participant.kills}/${participant.deaths}/${participant.assists}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${participant.minons} CS",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${(participant.goldEarned / 1000).toStringAsFixed(1)} k",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              /*Positioned(
                top: 150,
                left: 20,
                child: Text("${participant.kills}/${participant.deaths}/${participant.assists}",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
              ),
              Positioned(
                top: 150,
                left: 130,
                child: Text("${participant.minons} CS",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                ),
              Positioned(
                top: 150,
                right: 20,
                child: Text("${(participant.goldEarned / 1000).toStringAsFixed(1)} k",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
              ),*/
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
    return ShimmerLoading(
        isLoading: widget.model.buildingMatches, child: _buildCard());
  }
}

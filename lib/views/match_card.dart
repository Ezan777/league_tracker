import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/views/full_match_info.dart';

import '../models/model.dart';

class MatchCard extends StatefulWidget {
  final Model model;
  final int index;
  final BoxConstraints constraints;

  const MatchCard(
      {Key? key,
      required this.model,
      required this.index,
      required this.constraints})
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
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FullMatchInfo(
                    model: widget.model,
                    index: widget.index,
                  ))),
          child: Card(
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
                  top: 0.055 * widget.constraints.maxWidth,
                  left: 0.055 * widget.constraints.maxWidth,
                  child: Text(
                    participant.isWinner ? "Win" : "Loss",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 0.055 * widget.constraints.maxWidth,
                  right: 0.055 * widget.constraints.maxWidth,
                  child: Text(
                    widget.model.summoner.allMatches[widget.index].matchType ??
                        "",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned.fill(
                  top: 0.404 * widget.constraints.maxWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.7),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: widget.constraints.maxWidth),
                      child: FittedBox(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 0.80 * widget.constraints.maxWidth,
          height: 0.219 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}

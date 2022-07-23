import 'package:flutter/material.dart';
import 'package:league_tracker/views/summoner_info_view.dart';

import '../models/model.dart';

class SummonerCard extends StatefulWidget {
  final Model model;

  const SummonerCard({Key? key, required this.model}) : super(key: key);

  @override
  State<SummonerCard> createState() => _SummonerCardState();
}

class _SummonerCardState extends State<SummonerCard> {
  @override
  Widget build(BuildContext context) {
    if(widget.model.isSummonerInitialized) {
      /*TODO need to add two buttons at the end of the card, one for the match history and one for live matches, before that I need to add live match to darthus */
      // I was thinking to implement the match history and live match button, as buttons with containers as children
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SummonerInfo(
                isLoading: widget.model.isLoading,
                model: widget.model,
                parentConstraints: constraints,
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:league_tracker/views/summoner_info.dart';

import '../models/model.dart';

class SummonerCard extends StatefulWidget {
  final Model model;
  final BoxConstraints constraints;

  const SummonerCard({Key? key, required this.model, required this.constraints})
      : super(key: key);

  @override
  State<SummonerCard> createState() => _SummonerCardState();
}

class _SummonerCardState extends State<SummonerCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.model.isSummonerInitialized) {
      return Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: LayoutBuilder(
            builder: (context, constraints) => SummonerInfo(
              isLoading: widget.model.isLoading,
              model: widget.model,
              constraints: constraints,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

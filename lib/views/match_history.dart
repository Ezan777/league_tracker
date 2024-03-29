import 'package:flutter/material.dart';
import 'package:league_tracker/animated_shimmer/shimmer_loading.dart';
import 'package:league_tracker/views/match_card.dart';

import '../models/model.dart';

class MatchHistory extends StatefulWidget {
  final Model model;

  const MatchHistory({Key? key, required this.model}) : super(key: key);

  @override
  State<MatchHistory> createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ShimmerLoading(
              isLoading: widget.model.buildingMatches,
              child: LayoutBuilder(
                builder: (context, constraints) => MatchCard(
                  model: widget.model,
                  index: index,
                  constraints: constraints,
                ),
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}

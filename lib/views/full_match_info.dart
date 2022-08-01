import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/views/ExpandedParticipantRow.dart';
import 'package:league_tracker/views/participant_row.dart';

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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          onTap: () {
            widget.model.isExpanded[index].value =
                !widget.model.isExpanded[index].value;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: index < 5 ? Colors.blue : Colors.red,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    widget.model.isExpanded[index].value
                        ? ExpandedParticipantRow(
                            participant: participant,
                            constraints: constraints,
                            model: widget.model,
                          )
                        : ParticipantRow(
                            constraints: constraints,
                            participant: participant,
                            model: widget.model,
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchInfo() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => AnimatedBuilder(
              animation: widget.model.isExpanded[index],
              builder: (context, child) {
                return _buildParticipantInfoAt(index);
              },
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.model.matchMaxDamageToChampions = widget
        .model.summoner.allMatches[widget.index]
        .maxDamageDealtToChampions();

    widget.model.matchMaxDamageToObjectives = widget
        .model.summoner.allMatches[widget.index]
        .maxDamageDealtToObjectives();

    widget.model.matchMaxDamageTaken =
        widget.model.summoner.allMatches[widget.index].maxDamageTaken();

    return Scaffold(
      appBar: AppBar(
        title: const Text("League Tracker"),
      ),
      body: _buildMatchInfo(),
    );
  }
}

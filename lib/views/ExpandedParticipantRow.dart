import 'package:flutter/material.dart';
import 'package:league_tracker/views/participant_row.dart';

class ExpandedParticipantRow extends ParticipantRow {
  const ExpandedParticipantRow(
      {Key? key, required super.participant, required super.constraints})
      : super(key: key);

  @override
  ParticipantRowState createState() => _ExpandedParticipantRowState();
}

class _ExpandedParticipantRowState extends ParticipantRowState {
  @override
  Widget build(BuildContext context) {
    final damageTextStyle =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20);

    return Column(
      children: [
        super.buildRow(),
        const SizedBox(height: 5,),
        Container(
          constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    "Total damage dealt to champions: ${widget.participant.totalDamageDealtToChampions}",
                    style: damageTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    "Total damage taken: ${widget.participant.totalDamageTaken}",
                    style: damageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

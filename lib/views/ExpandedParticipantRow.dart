import 'package:flutter/material.dart';
import 'package:league_tracker/views/participant_row.dart';

class ExpandedParticipantRow extends ParticipantRow {
  const ExpandedParticipantRow(
      {Key? key,
      required super.participant,
      required super.constraints,
      required super.model})
      : super(key: key);

  @override
  ParticipantRowState createState() => _ExpandedParticipantRowState();
}

class _ExpandedParticipantRowState extends ParticipantRowState {
  @override
  Widget build(BuildContext context) {
    final damageTextStyle =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20);

    const detailsPadding = EdgeInsets.all(7);

    return Column(
      children: [
        super.buildRow(),
        const SizedBox(
          height: 5,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Column(
              children: [
                // Total damage dealt to champions text
                Padding(
                  padding: detailsPadding,
                  child: Text(
                    "Total damage dealt to champions:",
                    style: damageTextStyle,
                  ),
                ),
                // Total damage dealt to champions bar
                Padding(
                  padding: detailsPadding,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 0.4 * MediaQuery.of(context).size.width,
                            height: 0.03 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            width: (widget.participant.totalDamageDealtToChampions / widget.model.matchMaxDamageToChampions) * (0.4 * MediaQuery.of(context).size.width),
                            height: 0.03 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 0.04 * MediaQuery.of(context).size.width,),
                      Text(
                        "${widget.participant.totalDamageDealtToChampions} k",
                        style: damageTextStyle,
                      ),
                    ],
                  ),
                ),
                // Total damage to objectives Text
                Padding(
                  padding: detailsPadding,
                  child: Text(
                    "Total damage dealt to objectives:",
                    style: damageTextStyle,
                  ),
                ),
                // Total damage to objectives bar
                Padding(
                  padding: detailsPadding,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 0.4 * MediaQuery.of(context).size.width,
                            height: 0.03 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            width: (widget.participant.damageDealtToObjectives / widget.model.matchMaxDamageToObjectives) * (0.4 * MediaQuery.of(context).size.width),
                            height: 0.03 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 0.04 * MediaQuery.of(context).size.width,),
                      Text(
                        "${widget.participant.damageDealtToObjectives} k",
                        style: damageTextStyle,
                      ),
                    ],
                  ),
                ),
                // Vision score
                Padding(
                  padding: detailsPadding,
                  child: Row(
                    children: [
                      const Icon(Icons.visibility_outlined),
                      SizedBox(width: 0.03 * MediaQuery.of(context).size.width,),
                      Text("7"), /* TODO Need to update darthus to get vision score */
                    ],
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

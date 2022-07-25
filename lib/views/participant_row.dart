import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';

class ParticipantRow extends StatelessWidget {
  final FinishedParticipant participant;
  final BoxConstraints constraints;

  const ParticipantRow(
      {Key? key, required this.constraints, required this.participant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: constraints.maxWidth),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            // Champion Tile
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 0.24 * constraints.maxWidth,
                height: 0.25 * constraints.maxWidth,
                child: Stack(
                  children: [
                    Container(
                      width: 0.23 * constraints.maxWidth,
                      height: 0.23 * constraints.maxWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade900,
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                            "assets/images/champions_tiles/${participant.championInfo["championName"]}_0.jpg"),
                      ),
                    ),
                    Positioned(
                      top: 0.19 * constraints.maxWidth,
                      left: 0.07 * constraints.maxWidth,
                      child: Container(
                        width: 0.1 * constraints.maxWidth,
                        height: 0.06 * constraints.maxWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade900,
                          border: Border.all(
                            color: Colors.yellowAccent.shade700,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            participant.championInfo["championLevel"]
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _itemsFirstRow(),
                  _itemsSecondRow(),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                    ),
                text: "${(participant.goldEarned / 1000).toStringAsFixed(1)} k",
                children: [
                  WidgetSpan(
                    child: SizedBox(width: 0.01 * constraints.maxWidth,)
                  ),
                  const WidgetSpan(
                    child: Icon(Icons.paid_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemsFirstRow() {
    const padding = EdgeInsets.all(2);

    return Row(
      children: [
        Padding(
          padding: padding,
          child: _boxItemAt(0),
        ),
        Padding(
          padding: padding,
          child: _boxItemAt(1),
        ),
        Padding(
          padding: padding,
          child: _boxItemAt(2),
        ),
      ],
    );
  }

  Widget _itemsSecondRow() {
    const padding = EdgeInsets.all(2);

    return Row(
      children: [
        Padding(
          padding: padding,
          child: _boxItemAt(3),
        ),
        Padding(
          padding: padding,
          child: _boxItemAt(4),
        ),
        Padding(
          padding: padding,
          child: _boxItemAt(5),
        ),
      ],
    );
  }

  Widget _boxItemAt(int index) {
    return Container(
      width: 0.1 * constraints.maxWidth,
      height: 0.1 * constraints.maxWidth,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: participant.itemsId[index] != 0
              ? Image.asset(
                  "assets/images/items/${participant.itemsId[index]}.png")
              : const SizedBox()),
    );
  }
}

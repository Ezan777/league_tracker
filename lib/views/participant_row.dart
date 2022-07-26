import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';

class ParticipantRow extends StatefulWidget {
  final FinishedParticipant participant;
  final BoxConstraints constraints;

  const ParticipantRow(
      {Key? key, required this.participant, required this.constraints})
      : super(key: key);

  @override
  State<ParticipantRow> createState() => _ParticipantRowState();
}

class _ParticipantRowState extends State<ParticipantRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            // Champion Tile
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 0.24 * widget.constraints.maxWidth,
                height: 0.25 * widget.constraints.maxWidth,
                child: Stack(
                  children: [
                    Container(
                      width: 0.23 * widget.constraints.maxWidth,
                      height: 0.23 * widget.constraints.maxWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade900,
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                            "assets/images/champions_tiles/${widget.participant.championInfo["championName"]}_0.jpg"),
                      ),
                    ),
                    Positioned(
                      top: 0.19 * widget.constraints.maxWidth,
                      left: 0.07 * widget.constraints.maxWidth,
                      child: Container(
                        width: 0.1 * widget.constraints.maxWidth,
                        height: 0.06 * widget.constraints.maxWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade900,
                          border: Border.all(
                            color: Colors.yellowAccent.shade700,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.participant.championInfo["championLevel"]
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
              padding: const EdgeInsets.all(10),
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
                      color: Colors.yellow.shade800,
                    ),
                text:
                    "${(widget.participant.goldEarned / 1000).toStringAsFixed(1)} k",
                children: [
                  WidgetSpan(
                      child: SizedBox(
                    width: 0.01 * widget.constraints.maxWidth,
                  )),
                  WidgetSpan(
                    child: Icon(
                      Icons.paid_outlined,
                      color: Colors.yellow.shade800,
                      size: 18,
                    ),
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
      width: 0.1 * widget.constraints.maxWidth,
      height: 0.1 * widget.constraints.maxWidth,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.participant.itemsId[index] != 0
              ? Image.asset(
                  "assets/images/items/${widget.participant.itemsId[index]}.png")
              : const SizedBox()),
    );
  }
}

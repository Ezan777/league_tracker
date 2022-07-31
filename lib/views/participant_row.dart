import 'dart:convert';

import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParticipantRow extends StatefulWidget {
  final FinishedParticipant participant;
  final BoxConstraints constraints;

  const ParticipantRow(
      {Key? key, required this.participant, required this.constraints})
      : super(key: key);

  @override
  State<ParticipantRow> createState() => ParticipantRowState();
}

class ParticipantRowState extends State<ParticipantRow> {
  Future<String> summonerSpell1Name() async {
    final jsonFile = await rootBundle.loadString("assets/json/summoner.json");
    final data = jsonDecode(jsonFile)["data"]
        .map((String key, spell) => MapEntry(spell["key"], spell["id"]));

    return data[widget.participant.summonerSpells[0].toString()];
  }

  Future<String> summonerSpell2Name() async {
    final jsonFile = await rootBundle.loadString("assets/json/summoner.json");
    final data = jsonDecode(jsonFile)["data"]
        .map((String key, spell) => MapEntry(spell["key"], spell["id"]));

    return data[widget.participant.summonerSpells[1].toString()];
  }

  @override
  Widget build(BuildContext context) {
    return buildRow();
  }

  Widget buildRow() {
    final summonerSpell1 = summonerSpell1Name();
    final summonerSpell2 = summonerSpell2Name();

    return Container(
      constraints: BoxConstraints(maxWidth: widget.constraints.maxWidth),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            // Champion Tile
            Padding(
              padding: const EdgeInsets.all(3),
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
            // Summoner's name and spells
            Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summoner name
                  SizedBox(
                    width: 0.25 * widget.constraints.maxWidth,
                    child: Text(
                      widget.participant.summonerName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Summoner spells
                  Row(
                    children: [
                      // First summoner spell
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: 0.09 * widget.constraints.maxWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FutureBuilder(
                                future: summonerSpell1,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.asset(
                                      "assets/images/spells/${snapshot.data}.png",
                                    );
                                  } else {
                                    return Container(
                                      width: 0.09 * widget.constraints.maxWidth,
                                      height:
                                          0.09 * widget.constraints.maxWidth,
                                      decoration: BoxDecoration(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ),
                      // Second summoner spell
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: 0.09 * widget.constraints.maxWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FutureBuilder(
                                future: summonerSpell2,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.asset(
                                      "assets/images/spells/${snapshot.data}.png",
                                    );
                                  } else {
                                    return Container(
                                      width: 0.09 * widget.constraints.maxWidth,
                                      height:
                                          0.09 * widget.constraints.maxWidth,
                                      decoration: BoxDecoration(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // KDA and CS
            Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                children: [
                  Text(
                    "${widget.participant.kills}/${widget.participant.deaths}/${widget.participant.assists}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  Text(
                    "${widget.participant.minons.toString()} CS",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
            ),
            // Items
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _itemsFirstRow(),
                  _itemsSecondRow(),
                ],
              ),
            ),
            // Gold earned
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
      width: 0.08 * widget.constraints.maxWidth,
      height: 0.08 * widget.constraints.maxWidth,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.grey.shade300
            : Colors.grey.shade700,
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

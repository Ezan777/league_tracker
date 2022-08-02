import 'package:flutter/material.dart';
import 'package:league_tracker/models/model.dart';

enum LolServers { na1, euw1, eun1, kr, br1, jp1, ru1, oce, tr1, la1, la2 }

class RegionButton extends StatefulWidget {
  final Model _model;

  const RegionButton({Key? key, required Model model})
      : _model = model,
        super(key: key);

  @override
  State<RegionButton> createState() => _RegionButtonState();
}

class _RegionButtonState extends State<RegionButton> {
  final Map<LolServers, String> _serverRegion = {
    LolServers.na1: "NA",
    LolServers.euw1: "EUW",
    LolServers.eun1: "EUN",
    LolServers.kr: "KR",
    LolServers.br1: "BR",
    LolServers.jp1: "JP",
    LolServers.ru1: "RU",
    LolServers.oce: "OCE",
    LolServers.tr1: "TR",
    LolServers.la1: "LAN",
    LolServers.la2: "LAS"
  };

  void _select(LolServers selectedServer) {
    widget._model.server = selectedServer;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        );

    return PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<LolServers>>[
              PopupMenuItem(
                  value: LolServers.na1,
                  child: Text(
                    "NA",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.euw1,
                  child: Text(
                    "EUW",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.eun1,
                  child: Text(
                    "EUN",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.kr,
                  child: Text(
                    "KR",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.br1,
                  child: Text(
                    "BR",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.jp1,
                  child: Text(
                    "JP",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.ru1,
                  child: Text(
                    "RU",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.oce,
                  child: Text(
                    "OCE",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.tr1,
                  child: Text(
                    "TR",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.la1,
                  child: Text(
                    "LAN",
                    style: textStyle,
                  )),
              PopupMenuItem(
                  value: LolServers.la2,
                  child: Text(
                    "LAS",
                    style: textStyle,
                  )),
            ],
        onSelected: _select,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            height: 40,
            width: 55,
            child: Center(
              child: Text(_serverRegion[widget._model.server]!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      )),
            ),
          ),
        ));
  }
}

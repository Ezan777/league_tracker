import 'package:flutter/material.dart';
import 'package:league_tracker/search_model.dart';

enum LolServers { na1, euw1, eun1, kr, br1, jp1, ru1, oce, tr1, la1, la2 }

extension on LolServers {
  /// Returns the string corresponding to the abbreviation of the server's name
  /// used by riot games.
  ///
  /// For example if the server is EUW it returns euw1, if the server is NA it
  /// returns na1
  String toServerString() {
    return toString().split('.').last;
  }
}

class RegionButton extends StatefulWidget {
  final SearchModel _model;

  const RegionButton({Key? key, required SearchModel model})
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
    widget._model.setServer(server: selectedServer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<LolServers>>[
        const PopupMenuItem(value: LolServers.na1, child: Text("NA")),
        const PopupMenuItem(value: LolServers.euw1, child: Text("EUW")),
        const PopupMenuItem(value: LolServers.eun1, child: Text("EUN")),
        const PopupMenuItem(value: LolServers.kr, child: Text("KR")),
        const PopupMenuItem(value: LolServers.br1, child: Text("BR")),
        const PopupMenuItem(value: LolServers.jp1, child: Text("JP")),
        const PopupMenuItem(value: LolServers.ru1, child: Text("RU")),
        const PopupMenuItem(value: LolServers.oce, child: Text("OCE")),
        const PopupMenuItem(value: LolServers.tr1, child: Text("TR")),
        const PopupMenuItem(value: LolServers.la1, child: Text("LAN")),
        const PopupMenuItem(value: LolServers.la2, child: Text("LAS")),
      ],
      onSelected: _select,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Theme.of(context).buttonTheme.colorScheme!.background,
          height: 40,
          width: 55,
          child: Center(
            child: Text(_serverRegion[widget._model.server()]!,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
      )
    );
  }
}

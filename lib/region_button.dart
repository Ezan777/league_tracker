import 'package:flutter/material.dart';
import 'package:league_tracker/search_model.dart';

enum LolServers {na1, euw1, eun1, kr, br1, jp1, ru1, oce, tr1, la1, la2}

extension on LolServers {
  String toServerString() {
    return toString().split('.').last;
  }
}

class RegionButton extends StatefulWidget {
  final SearchModel _model;

  const RegionButton({Key? key, required SearchModel model}) : _model = model,
        super(key: key);

  @override
  State<RegionButton> createState() => _RegionButtonState();
}

class _RegionButtonState extends State<RegionButton> {

  /*final Map<String, String> _regions = {"NA": "na1", "EUW": "euw1", "EUN": "eun1",
    "KR": "kr",  "BR": "br1", "JP": "jp1", "RU": "ru1", "OCE": "oce",
    "TR": "tr1", "LAN": "la1", "LAS": "la2"};*/

  void _select(LolServers selectedServer) {
    widget._model.setRegion(region: selectedServer.toServerString());

  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) => <PopupMenuEntry<LolServers>>[
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
    onSelected: _select,);
  }
}

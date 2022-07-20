import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

class Model {
  final ValueNotifier<bool> isLoading;
  String searchedText;
  LolServers server;
  late Summoner summoner;

  Model(): isLoading = ValueNotifier<bool>(false), searchedText = '', server = LolServers.euw1;

  void buildSummoner() async {
    summoner = Summoner(server.toString().split('.').last, searchedText);
    await summoner.buildSummoner();
    await summoner.getMatches(numberOfMatches: 10);
    await summoner.buildAllMatches();
  }
}
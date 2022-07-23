import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

import '../api_key.dart';

class Model {
  ValueNotifier<bool> isLoading, showRankedFlex, buildingMatches;
  bool _isSummonerInitialized;
  String searchedText;
  LolServers server;
  late Summoner summoner;

  Model()
      : _isSummonerInitialized = false,
        isLoading = ValueNotifier<bool>(false),
        searchedText = '',
        server = LolServers.euw1,
        showRankedFlex = ValueNotifier<bool>(false),
        buildingMatches = ValueNotifier<bool>(false) {
    ApiRequest.setApiKey(key: myApiKey);
  }

  /// This function is going to build the summoner with 100 games in matchHistory
  Future<void> buildSummoner() async {
    if (searchedText != "") {
      summoner = Summoner(server.toString().split('.').last, searchedText);
      _isSummonerInitialized = true;
      isLoading.value = true;
      try {
        await summoner.buildSummoner();
        await summoner.getMatches(numberOfMatches: 100);
        isLoading.value = false;
      } catch(e) {
        _isSummonerInitialized = false;
        isLoading.value = false;
        rethrow;
      }
    }
  }

  /// Build the given number of matches.
  Future<void> buildMatches({int numberOfMatches = 5}) async {
    buildingMatches.value = true;
    for(int i = summoner.allMatches.length; i < numberOfMatches; ++i) {
      await summoner.buildMatchAt(i);
    }
    buildingMatches.value = false;
  }

  bool get isSummonerInitialized => _isSummonerInitialized;
}

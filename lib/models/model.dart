import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

import '../api_key.dart';

class Model {
  ValueNotifier<bool> isLoading, showRankedFlex, buildingMatches, showSearchBar;
  List<ValueNotifier<bool>> isExpanded;
  bool _isSummonerInitialized;
  String searchedText;
  LolServers server;
  int matchMaxDamageToChampions,
      matchMaxDamageToObjectives,
      matchMaxDamageTaken;
  late Summoner summoner;

  Model()
      : _isSummonerInitialized = false,
        isLoading = ValueNotifier<bool>(false),
        searchedText = '',
        server = LolServers.euw1,
        showRankedFlex = ValueNotifier<bool>(false),
        buildingMatches = ValueNotifier<bool>(false),
        showSearchBar = ValueNotifier<bool>(true),
        matchMaxDamageToChampions = 0,
        matchMaxDamageToObjectives = 0,
        matchMaxDamageTaken = 0,
        isExpanded = List.generate(10, (_) => ValueNotifier<bool>(false)) {
    ApiRequest.setApiKey(key: myApiKey);
  }

  /// This function is going to build the summoner with 20 games in matchHistory
  Future<void> buildSummoner() async {
    isLoading.value = false;
    if (searchedText != "") {
      summoner = Summoner(server.toString().split('.').last, searchedText);
      _isSummonerInitialized = true;
      isLoading.value = true;
      try {
        await summoner.buildSummoner();
        isLoading.value = false;
        await buildMatches(numberOfMatches: 20);
      } catch (e) {
        _isSummonerInitialized = false;
        isLoading.value = false;
        rethrow;
      }
    }
  }

  /// Build the given number of matches.
  Future<void> buildMatches({int numberOfMatches = 5}) async {
    buildingMatches.value = false;
    buildingMatches.value = true;
    for (int i = summoner.allMatches.length; i < numberOfMatches; ++i) {
      try {
        await summoner.buildMatchAt(i);
      } catch (e) {
        buildingMatches.value = false;
        /*await Future.delayed(const Duration(seconds: 5));
        if (i < numberOfMatches) {
          buildMatches(numberOfMatches: numberOfMatches);
        }*/
        rethrow;
      }
    }
    buildingMatches.value = false;
  }

  void resetMatchMaxDamages() {
    matchMaxDamageTaken = 0;
    matchMaxDamageToObjectives = 0;
    matchMaxDamageToChampions = 0;
  }

  bool get isSummonerInitialized => _isSummonerInitialized;
}

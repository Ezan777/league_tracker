import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

import '../api_key.dart';

class Trial implements Exception {}

class Model {
  ValueNotifier<bool> isLoading, showRankedFlex;
  bool _isSummonerInitialized;
  String searchedText;
  LolServers server;
  late Summoner summoner;

  Model()
      : _isSummonerInitialized = false,
        isLoading = ValueNotifier<bool>(false),
        searchedText = '',
        server = LolServers.euw1,
        showRankedFlex = ValueNotifier<bool>(false) {
    ApiRequest.setApiKey(key: myApiKey);
  }

  Future<void> buildSummoner() async {
    if (searchedText != "") {
      summoner = Summoner(server.toString().split('.').last, searchedText);
      _isSummonerInitialized = true;
      isLoading.value = true;
      try {
        await summoner.buildSummoner();
      } on DataNotFound {
        _isSummonerInitialized = false;
        isLoading.value = false;
        rethrow;
      }
      isLoading.value = false;
    }
  }

  bool get isSummonerInitialized => _isSummonerInitialized;
}

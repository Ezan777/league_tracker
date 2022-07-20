import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

import '../api_key.dart';

class Model {
  ValueNotifier<bool> isLoading;
  bool _isSummonerInitialized;
  String searchedText;
  LolServers server;
  late Summoner summoner;

  Model(): _isSummonerInitialized = false, isLoading = ValueNotifier<bool>(false), searchedText = '', server = LolServers.euw1 {
    ApiRequest.setApiKey(key: myApiKey);
  }

  void buildSummoner() async {
    summoner = Summoner(server.toString().split('.').last, searchedText);
    _isSummonerInitialized = true;
    isLoading.value = true;
    await summoner.buildSummoner();
    isLoading.value = false;
  }

  bool get isSummonerInitialized => _isSummonerInitialized;
}
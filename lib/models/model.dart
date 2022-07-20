import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:darthus/darthus.dart';

import '../api_key.dart';

class Model {
  ValueNotifier<bool> isLoading;
  String searchedText;
  LolServers server;
  late Summoner summoner;

  Model(): isLoading = ValueNotifier<bool>(false), searchedText = '', server = LolServers.euw1 {
    ApiRequest.setApiKey(key: myApiKey);
  }

  void buildSummoner() async {
    isLoading.value = true;
    summoner = Summoner(server.toString().split('.').last, searchedText);
    await summoner.buildSummoner();
    isLoading.value = false;
  }
}
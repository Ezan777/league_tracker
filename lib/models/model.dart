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
    await Future.delayed(Duration(seconds: 3));
    /*summoner = Summoner('euw1'*//*server.toString().split('.').last*//*, 'zan777');
    await summoner.buildSummoner();
    await summoner.getMatches(numberOfMatches: 7);
    await summoner.buildAllMatches();*/
    isLoading.value = false;
  }
}
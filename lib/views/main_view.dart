import 'package:flutter/material.dart';
import 'package:league_tracker/views/match_history.dart';
import 'package:league_tracker/views/search_bar.dart';
import 'package:league_tracker/views/summoner_card.dart';

import '../models/model.dart';

class MainView extends StatefulWidget {
  final Model model;

  const MainView({Key? key, required this.model}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final summonerCardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SearchBar(model: widget.model),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: widget.model.isLoading,
          builder: (BuildContext context, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: SummonerCard(
                model: widget.model,
              ),
            );
          },
        ),
        //MatchHistory(model: widget.model),
      ],
    );
  }
}

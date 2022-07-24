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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: widget.model.showSearchBar,
            builder: (BuildContext context, Widget? child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: widget.model.showSearchBar.value ? Column(
                  children: [
                    SizedBox(height: widget.model.showSearchBar.value ? 20 : 0),
                    SearchBar(model: widget.model),
                    SizedBox(height: widget.model.showSearchBar.value ? 20 : 0),
                  ],
                )
                : const SizedBox(),
              );
            }),
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
        //const SizedBox(height: 15,),
        Expanded(
          child: CustomScrollView(
            slivers: [
              AnimatedBuilder(
                  animation: widget.model.buildingMatches,
                  builder: (BuildContext context, Widget? child) {
                    return MatchHistory(model: widget.model);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

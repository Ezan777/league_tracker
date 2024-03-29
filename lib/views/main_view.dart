import 'package:flutter/material.dart';
import 'package:league_tracker/views/match_history.dart';
import 'package:league_tracker/views/search_bar.dart';
import 'package:league_tracker/views/summoner_card.dart';

import '../models/model.dart';

class MainView extends StatefulWidget {
  final Model model;
  final BoxConstraints constraints;

  const MainView({Key? key, required this.model, required this.constraints})
      : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget _buildNormalView() {
    return Column(
      children: [
        // Searchbar
        AnimatedBuilder(
          animation: widget.model.showSearchBar,
          builder: (BuildContext context, Widget? child) {
            return AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(
                scale: animation,
                child: child,
              ),
              duration: const Duration(milliseconds: 200),
              child: widget.model.showSearchBar.value
                  ? Column(
                      children: [
                        SizedBox(
                            height: widget.model.showSearchBar.value ? 20 : 0),
                        SearchBar(
                          model: widget.model,
                          constraints: widget.constraints,
                        ),
                        SizedBox(
                            height: widget.model.showSearchBar.value ? 20 : 0),
                      ],
                    )
                  : const SizedBox(),
            );
          },
        ),
        // Summoner card
        AnimatedBuilder(
          animation: widget.model.isLoading,
          builder: (BuildContext context, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: SummonerCard(
                model: widget.model,
                constraints: widget.constraints,
              ),
            );
          },
        ),
        // Match history
        AnimatedBuilder(
          animation: widget.model.buildingMatches,
          builder: (context, child) {
            if (widget.model.buildingMatches.value) {
              return Expanded(
                child: CustomScrollView(
                  slivers: [
                    AnimatedBuilder(
                        animation: widget.model.buildingMatches,
                        builder: (BuildContext context, Widget? child) {
                          return MatchHistory(model: widget.model);
                        }),
                  ],
                  physics: const NeverScrollableScrollPhysics(),
                ),
              );
            } else {
              return Expanded(
                child: CustomScrollView(
                  slivers: [
                    AnimatedBuilder(
                        animation: widget.model.buildingMatches,
                        builder: (BuildContext context, Widget? child) {
                          return MatchHistory(model: widget.model);
                        }),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildLargeView() {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: 0.45 * MediaQuery.of(context).size.width),
          child: Column(
            children: [
              // Searchbar
              AnimatedBuilder(
                animation: widget.model.showSearchBar,
                builder: (BuildContext context, Widget? child) {
                  return AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    duration: const Duration(milliseconds: 200),
                    child: widget.model.showSearchBar.value
                        ? Column(
                            children: [
                              SizedBox(
                                  height: widget.model.showSearchBar.value
                                      ? 20
                                      : 0),
                              LayoutBuilder(
                                builder: (context, constraints) => SearchBar(
                                  model: widget.model,
                                  constraints: constraints,
                                ),
                              ),
                              SizedBox(
                                  height: widget.model.showSearchBar.value
                                      ? 20
                                      : 0),
                            ],
                          )
                        : const SizedBox(),
                  );
                },
              ),
              // Summoner card
              AnimatedBuilder(
                animation: widget.model.isLoading,
                builder: (BuildContext context, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: SummonerCard(
                      model: widget.model,
                      constraints: widget.constraints,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Match History
        Expanded(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: widget.model.buildingMatches,
                builder: (context, child) {
                  if (widget.model.buildingMatches.value) {
                    return Expanded(
                      child: CustomScrollView(
                        slivers: [
                          AnimatedBuilder(
                              animation: widget.model.buildingMatches,
                              builder: (BuildContext context, Widget? child) {
                                return MatchHistory(model: widget.model);
                              }),
                        ],
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: CustomScrollView(
                        slivers: [
                          AnimatedBuilder(
                              animation: widget.model.buildingMatches,
                              builder: (BuildContext context, Widget? child) {
                                return MatchHistory(model: widget.model);
                              }),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.model.isLargeScreen) {
      return _buildLargeView();
    } else {
      return _buildNormalView();
    }
  }
}

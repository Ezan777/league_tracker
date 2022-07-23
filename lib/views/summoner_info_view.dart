import 'package:flutter/material.dart';
import 'package:league_tracker/animated_shimmer/shimmer_loading.dart';

import '../models/model.dart';

class SummonerInfo extends StatefulWidget {
  final ValueNotifier<bool> isLoading;
  final Model model;
  final BoxConstraints? parentConstraints;

  const SummonerInfo({Key? key, required this.isLoading, required this.model, this.parentConstraints})
      : super(key: key);

  @override
  State<SummonerInfo> createState() => _SummonerInfoState();
}

class _SummonerInfoState extends State<SummonerInfo> {
  @override
  Widget build(BuildContext context) {
    Widget _buildSummonerIcon() {
      if (widget.isLoading.value) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile_icon/${widget.model.summoner.iconId}.png',
              ),
            ),
          ),
        );
      }
    }

    Widget _buildText() {
      if (widget.isLoading.value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.parentConstraints != null ? 0.55 * widget.parentConstraints!.maxWidth : 0.55 * MediaQuery.of(context).size.width,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: widget.parentConstraints != null ? 0.23 * widget.parentConstraints!.maxWidth : 0.23 * MediaQuery.of(context).size.width,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: widget.parentConstraints != null ? 0.58 * widget.parentConstraints!.maxWidth : 0.61 * MediaQuery.of(context).size.width),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "${widget.model.summoner.summonerName[0].toUpperCase()}${widget.model.summoner.summonerName.substring(1)}",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Theme.of(context).textTheme.headline3!.color
                          : Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Level: ${widget.model.summoner.summonerLevel}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20),
            ),
          ],
        );
      }
    }

    Widget _buildRankedSoloDuoInfo() {
      Color rankedTextColor = Theme.of(context).primaryColor;
      Widget rankedText = const Text("");
      Widget lpText = const Text(""), winRateText = const Text("");
      final double rankMaxWidth = widget.parentConstraints != null ? 0.90 * widget.parentConstraints!.maxWidth : MediaQuery.of(context).size.width;

      if (!widget.model.isLoading.value) {
        String tierString =
            "${widget.model.summoner.rankSoloDuo != null ? widget.model.summoner.rankSoloDuo!.tier.toUpperCase() : "UNRANKED"} ";
        String rankString = widget.model.summoner.rankSoloDuo != null
            ? " ${widget.model.summoner.rankSoloDuo!.rank}"
            : "";
        String lpString = widget.model.summoner.rankSoloDuo != null
            ? ": ${widget.model.summoner.rankSoloDuo!.lp} LP"
            : "";
        if (widget.model.summoner.rankSoloDuo != null) {
          switch (widget.model.summoner.rankSoloDuo!.tier.toLowerCase()) {
            case ("iron"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.grey.shade800
                  : rankedTextColor = Colors.grey;
              break;
            case ("bronze"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.brown
                  : rankedTextColor = Colors.brown.shade300;
              break;
            case ("silver"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.grey.shade600
                  : rankedTextColor = Colors.grey.shade400;
              break;
            case ("gold"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.lime.shade800
                  : rankedTextColor = Colors.lime.shade600;
              break;
            case ("platinum"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.teal
                  : rankedTextColor = Colors.teal.shade400;
              break;
            case ("diamond"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.blue.shade700
                  : rankedTextColor = Colors.blue;
              break;
            case ("master"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.purple.shade700
                  : rankedTextColor = Colors.purple.shade400;
              rankString = "";
              break;
            case ("grandmaster"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.red.shade600
                  : rankedTextColor = Colors.redAccent.shade400;
              rankString = "";
              break;
            case ("challenger"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.amber.shade600
                  : rankedTextColor = Colors.amber;
              rankString = "";
          }
        }

        rankedText = Text(
          "$tierString$rankString",
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
                color: rankedTextColor,
              ),
        );

        lpText = Text(
          lpString,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
                color: rankedTextColor,
              ),
        );

        winRateText = Text(
          "Win rate: ${widget.model.summoner.rankSoloDuo != null
          ? widget.model.summoner.rankSoloDuo!.winPercentage.toString()
          : ""}%",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 20, color: rankedTextColor),
        );

        return Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: rankMaxWidth),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [rankedText, lpText],
                  ),
                ),
              ),
            ),
            widget.model.summoner.rankSoloDuo != null
            ? Container(
              constraints: BoxConstraints(maxWidth: 0.50 * rankMaxWidth),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FittedBox(
                  fit:  BoxFit.fitWidth,
                  child: winRateText,
                ),
              ),
            )
                : const SizedBox(),
          ],
        );
      } else {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 0.99 * rankMaxWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 0.50 * rankMaxWidth,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )
          ],
        );
      }
    }

    Widget _buildRankedFlexInfo() {
      Color rankedTextColor = Theme.of(context).primaryColor;
      Widget rankedText = const Text("");
      Widget lpText = const Text(""), winRateText = const Text("");
      final double rankMaxWidth = widget.parentConstraints != null ? 0.90 * widget.parentConstraints!.maxWidth : MediaQuery.of(context).size.width;

      if (!widget.model.isLoading.value) {
        String tierString =
            "${widget.model.summoner.rankFlex != null ? widget.model.summoner.rankFlex!.tier.toUpperCase() : "UNRANKED"} ";
        String rankString = widget.model.summoner.rankFlex != null
            ? " ${widget.model.summoner.rankFlex!.rank}"
            : "";
        String lpString = widget.model.summoner.rankFlex != null
            ? ": ${widget.model.summoner.rankFlex!.lp} LP"
            : "";
        if (widget.model.summoner.rankFlex != null) {
          switch (widget.model.summoner.rankFlex!.tier.toLowerCase()) {
            case ("iron"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.grey.shade800
                  : rankedTextColor = Colors.grey;
              break;
            case ("bronze"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.brown
                  : rankedTextColor = Colors.brown.shade300;
              break;
            case ("silver"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.grey.shade600
                  : rankedTextColor = Colors.grey.shade400;
              break;
            case ("gold"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.lime.shade800
                  : rankedTextColor = Colors.lime.shade600;
              break;
            case ("platinum"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.teal
                  : rankedTextColor = Colors.teal.shade400;
              break;
            case ("diamond"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.blue.shade700
                  : rankedTextColor = Colors.blue;
              break;
            case ("master"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.purple.shade700
                  : rankedTextColor = Colors.purple.shade400;
              rankString = "";
              break;
            case ("grandmaster"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.red.shade600
                  : rankedTextColor = Colors.redAccent.shade400;
              rankString = "";
              break;
            case ("challenger"):
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? rankedTextColor = Colors.amber.shade600
                  : rankedTextColor = Colors.amber;
              rankString = "";
          }
        }

        rankedText = Text(
          "$tierString$rankString",
          style: Theme.of(context).textTheme.headline3!.copyWith(
            fontWeight: FontWeight.bold,
            color: rankedTextColor,
          ),
        );

        lpText = Text(
          lpString,
          style: Theme.of(context).textTheme.headline3!.copyWith(
            fontWeight: FontWeight.bold,
            color: rankedTextColor,
          ),
        );

        winRateText = Text(
          "Win rate: ${widget.model.summoner.rankFlex != null
              ? widget.model.summoner.rankFlex!.winPercentage.toString()
              : ""}%",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 20, color: rankedTextColor),
        );

        return Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: rankMaxWidth),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [rankedText, lpText],
                  ),
                ),
              ),
            ),
            widget.model.summoner.rankFlex != null
                ? Container(
              constraints: BoxConstraints(maxWidth: 0.50 * rankMaxWidth),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FittedBox(
                  fit:  BoxFit.fitWidth,
                  child: winRateText,
                ),
              ),
            )
                : const SizedBox(),
          ],
        );
      } else {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 0.99 * rankMaxWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 0.50 * rankMaxWidth,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )
          ],
        );
      }
    }

    Widget _buildView() {
      if (widget.model.isSummonerInitialized) {
        return ShimmerLoading(
          isLoading: widget.model.isLoading,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Center(
                    child: _buildSummonerIcon(),
                  ),
                  _buildText(),
                ],
              ),
              _buildRankedSoloDuoInfo(),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return _buildView();
  }
}

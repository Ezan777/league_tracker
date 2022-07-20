//import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class SummonerInfo extends StatefulWidget {
  final ValueNotifier<bool> isLoading;
  final Model model;

  const SummonerInfo({Key? key, required this.isLoading, required this.model})
      : super(key: key);

  @override
  State<SummonerInfo> createState() => _SummonerInfoState();
}

class _SummonerInfoState extends State<SummonerInfo> {
  @override
  Widget build(BuildContext context) {
    //final Summoner summoner;

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
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: ClipOval(
              child: Image.asset(
                  'assets/images/profile_icon/${widget.model.summoner.iconId()}.png'),
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
              width: 0.65 * MediaQuery.of(context).size.width,
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
              width: 0.25 * MediaQuery.of(context).size.width,
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
            Text(
              "${widget.model.summoner.summonerName()[0].toUpperCase()}${widget.model.summoner.summonerName().substring(1)}",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Level: ${widget.model.summoner.summonerLevel()}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20),
            ),
          ],
        );
      }
    }

    Widget _buildView() {
      if (widget.model.isSummonerInitialized) {
        return Row(
          children: <Widget>[
            Center(
              child: _buildSummonerIcon(),
            ),
            _buildText(),
          ],
        );
      } else {
        return const SizedBox();
      }
    }

    return _buildView();
  }
}

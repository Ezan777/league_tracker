//import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';

class SummonerInfo extends StatefulWidget {
  final bool isLoading;

  const SummonerInfo({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<SummonerInfo> createState() => _SummonerInfoState();
}

class _SummonerInfoState extends State<SummonerInfo> {
  @override
  Widget build(BuildContext context) {
    //final Summoner summoner;

    Widget _buildSummonerIcon() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: ClipOval(
            child: Image.asset('assets/images/profile_icon/4597.png'),
          ),
        ),
      );
    }

    Widget _buildText() {
      if(widget.isLoading) {
        return Column(
          children: [
            Container(
              width: 0.65 * MediaQuery.of(context).size.width,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 10,),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: const [
              Text("Summoner name"),
              SizedBox(height: 10,),
              Text("Summoner level"),
            ],
          ),
        );
      }
    }

    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            _buildSummonerIcon(),
            _buildText(),
          ],
        ),
      ),
    );
  }
}

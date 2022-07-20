import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:league_tracker/models/search_model.dart';

class SearchBar extends StatefulWidget {
  final SearchModel _model;

  const SearchBar({Key? key, required SearchModel model}) : _model = model, super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  void _submitted(String text) {
    widget._model.setSearchedText(text: text);
  }

  @override
  Widget build(BuildContext context) {

    final bool isLargeScreen = MediaQuery.of(context).size.shortestSide > 600;
    final double portraitsMultiplicative, landscapeMultiplicative;

    if(isLargeScreen) {
      portraitsMultiplicative = 0.85;
      landscapeMultiplicative = 0.92;
    } else {
      portraitsMultiplicative = 0.78;
      landscapeMultiplicative = 0.88;
    }

    return Row(children: <Widget>[
      const SizedBox(width: 10),
      RegionButton(model: widget._model),
      const SizedBox(width: 15,),
      SizedBox(
        width: MediaQuery.of(context).orientation == Orientation.portrait ?
        (portraitsMultiplicative) * MediaQuery.of(context).size.width :
        (landscapeMultiplicative) * MediaQuery.of(context).size.width,
        child: TextField(
          decoration: const InputDecoration(
            labelText: "Summoner's name",
            border: OutlineInputBorder(),
          ),
          onSubmitted: _submitted,
        ),
      )
    ],);
  }
}

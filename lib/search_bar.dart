import 'package:flutter/material.dart';
import 'package:league_tracker/region_button.dart';
import 'package:league_tracker/search_model.dart';

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
    return Row(children: <Widget>[
      const SizedBox(width: 10),
      RegionButton(model: widget._model),
      const SizedBox(width: 15,),
      SizedBox(
        width: 320,
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

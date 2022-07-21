import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:league_tracker/models/model.dart';

class SearchBar extends StatefulWidget {
  final Model _model;

  const SearchBar({Key? key, required Model model})
      : _model = model,
        super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  void _submitted(String text) async {
    widget._model.searchedText = text;
    try {
      await widget._model.buildSummoner();
    } on DataNotFound {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text("Data not found"),
                content: const Text(
                    "The summoner's name you have inserted does not exist."),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.shortestSide > 600;
    final double portraitsMultiplicative, landscapeMultiplicative;

    if (isLargeScreen) {
      portraitsMultiplicative = 0.85;
      landscapeMultiplicative = 0.92;
    } else {
      portraitsMultiplicative = 0.78;
      landscapeMultiplicative = 0.88;
    }

    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        RegionButton(model: widget._model),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? (portraitsMultiplicative) * MediaQuery.of(context).size.width
              : (landscapeMultiplicative) * MediaQuery.of(context).size.width,
          child: TextField(
            decoration: const InputDecoration(
              labelText: "Summoner's name",
              border: OutlineInputBorder(),
            ),
            onSubmitted: _submitted,
          ),
        )
      ],
    );
  }
}

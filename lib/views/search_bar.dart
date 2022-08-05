import 'dart:io';

import 'package:darthus/darthus.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/views/region_button.dart';
import 'package:league_tracker/models/model.dart';

class SearchBar extends StatefulWidget {
  final Model _model;
  final BoxConstraints constraints;

  const SearchBar({Key? key, required Model model, required this.constraints})
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
      widget._model.showSearchBar.value = false;
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
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ),
          ],
        ),
      );
    } on RateLimitExceeded {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Request rate limit exceeded"),
          content: const Text(
              "There are too many requests, wait a moment and try again please"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ),
          ],
        ),
      );
    } on SocketException {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Service unavailable"),
          content: const Text(
              "The service is currently unavailable, it could be your internet connection or Riot's servers"),
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
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._model.showSearchBar.value) {
      return Row(
        children: <Widget>[
          const SizedBox(width: 10),
          RegionButton(model: widget._model),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 0.76 * widget.constraints.maxWidth,
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
    } else {
      return const SizedBox();
    }
  }
}

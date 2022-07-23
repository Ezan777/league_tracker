import 'package:flutter/material.dart';
import 'package:league_tracker/models/model.dart';

class SwitchRankedButton extends StatefulWidget {
  final Model model;

  const SwitchRankedButton({Key? key, required this.model}) : super(key: key);

  @override
  State<SwitchRankedButton> createState() => _SwitchRankedButtonState();
}

class _SwitchRankedButtonState extends State<SwitchRankedButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        const PopupMenuItem(value: "SoloDuo", child: Text("Ranked Solo/Duo")),
        const PopupMenuItem(value: "Flex", child: Text("Ranked Flex")),
      ],
      onSelected: (String selected) {
        if (!widget.model.showRankedFlex.value) {
          if (selected != "SoloDuo") {
            widget.model.showRankedFlex.value = true;
          }
        } else {
          if (selected == "SoloDuo") {
            widget.model.showRankedFlex.value = false;
          }
        }
        setState(() {});
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      color: Theme.of(context).popupMenuTheme.color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: widget.model.showRankedFlex.value
                    ? "Ranked Flex"
                    : "Ranked Solo/Duo",
              ),
              const WidgetSpan(
                  child: Icon(Icons.expand_more),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

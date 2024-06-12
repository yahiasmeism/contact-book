import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StarFavoriteToggle extends StatefulWidget {
  StarFavoriteToggle({
    super.key,
    required this.initalValue,
    this.favoriteToggle,
  });
  bool initalValue;

  final Function(bool value)? favoriteToggle;
  @override
  State<StarFavoriteToggle> createState() => _StarFavoriteToggleState();
}

class _StarFavoriteToggleState extends State<StarFavoriteToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.initalValue = !widget.initalValue;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: widget.initalValue
            ? const Icon(
                Icons.star,
                size: 30,
                color: Colors.amber,
              )
            : const Icon(
                Icons.star_border,
                size: 30,
              ),
      ),
    );
  }
}

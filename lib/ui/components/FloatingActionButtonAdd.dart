
import 'package:flutter/material.dart';
class FloatingActionButtonAdd extends StatelessWidget {
  final Function() onPressed;
  const FloatingActionButtonAdd({
    super.key, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightElevation: 0,
      hoverElevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: const Icon(Icons.add),
    );
  }
}
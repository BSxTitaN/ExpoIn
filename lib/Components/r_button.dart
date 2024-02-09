import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../Design-System/app_font.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.colour, required this.title, required this.onPressed, required this.shadow, this.textColor});

  final Color colour;
  final Color? shadow;
  final Color? textColor;
  final String title;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {

    return Bounceable(
      onTap: onPressed,
      child: Material(
        elevation: 25,
        color: colour,
        shadowColor: shadow,
        borderRadius: BorderRadius.circular(50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: SizedBox(
            height: 60.0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFont.button,
                  fontFamily: 'Satoshi',
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../theme/color_schemes.g.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Divider(height: 2,thickness: 2,color: tertiary),
            )
        ),
        ImageIcon(
          AssetImage("assets/icons/logo.png"),
          size: 64,
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Divider(height: 2,thickness: 2,color: tertiary),
            )
        )
      ],
    );
  }
}
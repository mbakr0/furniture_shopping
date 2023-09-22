


import 'package:flutter/cupertino.dart';

import '../../theme/color_schemes.g.dart';

class BagContainer extends StatelessWidget {
  const BagContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 30,width: 30,
        decoration: BoxDecoration(
          color:  onPrimaryContainerAlpha40,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset("assets/icons/bag.png"),
        ),

      ),
    );
  }

}
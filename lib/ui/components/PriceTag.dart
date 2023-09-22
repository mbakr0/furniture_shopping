

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/color_schemes.g.dart';

class PriceTag extends StatelessWidget {
  final double price;
  const PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text("\$ $price",style: GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.bold,color: onSurface));
  }

}



import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/color_schemes.g.dart';

class ProductName extends StatelessWidget {
  final String name;
  const ProductName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name,style: GoogleFonts.nunitoSans(fontSize: 14,fontWeight: FontWeight.normal,color: onPrimaryContainer));
  }

}
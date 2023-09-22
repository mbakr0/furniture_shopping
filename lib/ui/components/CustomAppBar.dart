



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/color_schemes.g.dart';

AppBar customAppBar(String title) {
  return AppBar(
    title: Text(title,style: GoogleFonts.merriweather(fontSize: 16,fontWeight: FontWeight.bold,color: onSurface),),
    backgroundColor: Colors.white,
    centerTitle: true,
  );
}
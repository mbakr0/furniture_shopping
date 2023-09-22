import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const onPrimary = Color(0xFF242424);
const primaryContainer = Color(0xFF27AE60);
const secondary = Color(0xFFF0F0F0);
const onSecondary =  Color(0xFF808080);
const surface =  Color(0xFFB3B3B3);
const outline =  Color(0xFFDBDBDB);
const tertiaryContainer =  Color(0xFFF5F5F5);
const tertiary =  Color(0xFF999999);
const onPrimaryContainer = Color(0xFF606060);
const onPrimaryContainerAlpha40 = Color(0x66606060);
const onSurface = Color(0xFF303030);

const starColor = Color(0xFFF2C94C);
const unFillStartColor = Color(0x41F2C94C);

const dateColor = Color(0xFF909090);

const fillColor = Color(0xFFF1F4F8);
const focusBorderColor = Color(0xFF4B39EF);

const seedColor = Colors.white;

SnackBar getSnackBar(String text,{Color color = Colors.red,Color fontColor = Colors.white,int milliseconds = 400}){
  return SnackBar(
    duration: Duration(milliseconds: milliseconds),
  backgroundColor: color,
      content: Center(
          child: Text(
            text,
            style: GoogleFonts.nunitoSans(fontSize: 16,fontWeight: FontWeight.normal,color: fontColor),
          )
      )
  );
}


ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      onSecondary:onSecondary,
      surface:surface,
      outline:outline,
      tertiaryContainer:tertiaryContainer,
      tertiary:tertiary,
      onPrimaryContainer: onPrimaryContainer,
      onSurface: onSurface
  ),
);


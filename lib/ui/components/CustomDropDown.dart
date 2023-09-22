



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/color_schemes.g.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onPressed;
  const CustomDropDown({super.key,required this.title,required this.subTitle,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title),
      subtitle: Text(subTitle),
      titleTextStyle: GoogleFonts.nunitoSans(fontSize: 12,fontWeight: FontWeight.normal,color: onSecondary),
      subtitleTextStyle: (subTitle == "Select Country" || subTitle == "Select City")
          ?GoogleFonts.nunitoSans(fontSize: 16,fontWeight: FontWeight.bold,color: surface):
      GoogleFonts.nunitoSans(fontSize: 16,fontWeight: FontWeight.bold,color: onPrimary),
      trailing:  Ink(child: const Icon(Icons.arrow_drop_down),),
    );
  }
}
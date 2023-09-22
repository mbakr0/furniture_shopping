


import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../theme/color_schemes.g.dart';

class CheckBoxWithText extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Function(bool?)? onChange;

  const CheckBoxWithText({super.key,required this.text,required this.isChecked, required this.onChange});

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      onChanged: onChange,
      contentPadding: const EdgeInsets.fromLTRB(4,0,4,0),
      value: isChecked,
      title: Text(text,style: GoogleFonts.nunitoSans(fontSize: 18,fontWeight: FontWeight.normal,color: onPrimary),),
      activeColor: onPrimary,
      checkColor: fillColor,
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

}
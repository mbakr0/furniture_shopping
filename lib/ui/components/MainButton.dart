
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
   const MainButton({
    super.key,required this.text,required this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w600,
          fontSize: 18
        )
      ),
      child:  Text(text)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/color_schemes.g.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputType keyboardType;
  final bool enabled;
  final String? initialValue;
  final TextEditingController? textController;

  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.keyboardType,
      this.textController,
      this.validator,
      this.inputFormatters,
      this.onChange,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.enabled = true,
      this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  final hintStyle = GoogleFonts.nunitoSans(fontSize: 10, color: tertiary);
  final textStyle = GoogleFonts.nunitoSans(fontSize: 20, color: onPrimary, fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      controller: widget.textController,
      style: textStyle,
      enabled: widget.enabled,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          focusColor: onPrimary,
          filled: true,
          hintText: widget.label,
          labelStyle: hintStyle,
          border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none)),
      keyboardType: widget.keyboardType,
    );
  }
}

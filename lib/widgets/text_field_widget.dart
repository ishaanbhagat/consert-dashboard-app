import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.width,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.obsecureText = false,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
    this.keyboardType,
    this.onTap,
    this.autofocus = false,
    this.suffixIconConstraints,
    this.onSubmitted,
    this.validator,
  });

  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final double? width;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool obsecureText;
  final void Function(String)? onChanged;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final bool autofocus;
  final BoxConstraints? suffixIconConstraints;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      onTap: onTap,
      maxLines: maxLines,
      controller: controller,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        // height: 0,
        color: Colors.black,
      ),
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: textInputAction,
      obscureText: obsecureText,
      onChanged: onChanged,
      // onSubmitted: onSubmitted,
      validator: validator,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        
        // prefixIconConstraints: BoxConstraints(
        //   maxWidth: 120.w,
        //   minWidth: 120.w,
        // ),
        // errorStyle: TextStyle(color: Colors.blue),
        prefixIcon: prefixIcon,
        suffixIconConstraints: suffixIconConstraints ?? BoxConstraints(
          maxWidth: 40.w,
          minWidth: 40.w,
        ),
        suffixIcon: suffixIcon,
        
      ),
    );
  }
}

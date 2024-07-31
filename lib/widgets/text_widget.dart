import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.title, {
    super.key,
    this.bodyLage = false,
    this.bodyMedium = false,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.fontStyle,
    this.height,
    this.overflow,

  });

  final String title;
  final bool bodyLage;
  final bool bodyMedium;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? height;
  final TextOverflow? overflow;


  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: bodyLage
          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                height:  0,
              )
          : bodyMedium
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: 0,

              )
              : Theme.of(context).textTheme.bodySmall!.copyWith(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: height ?? 0,
fontStyle: fontStyle,
              ),
    );
  }
}

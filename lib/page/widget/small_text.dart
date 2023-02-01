import 'package:flutter/cupertino.dart';

import '../../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double size;
  final bool softWrap;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const SmallText(
      { this.text,
        this.color = const Color(0xFF070707),
        this.size = 0,
        this.fontWeight,
        this.textAlign,
        this.overflow = TextOverflow.fade,
        this.softWrap = true,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: size ==0 ? Dimensions.font12:size,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
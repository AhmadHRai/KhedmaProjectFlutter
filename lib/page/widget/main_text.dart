import 'package:flutter/cupertino.dart';

import '../../utils/dimensions.dart';


class MainText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final bool softWrap;
  final TextOverflow overflow;
  const MainText(
      { this.text,
        this.color = const Color(0xFF000000),
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
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        color: color,
        fontSize: size ==0 ? Dimensions.font26:size,
        fontWeight: fontWeight,
      ),
    );
  }
}
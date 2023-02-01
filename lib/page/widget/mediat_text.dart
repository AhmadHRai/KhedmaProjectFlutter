import 'package:flutter/cupertino.dart';

import '../../utils/dimensions.dart';

class MediatText extends StatelessWidget {
  Color? color;
  String? text;
  double size;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  bool softWrap;
  TextOverflow overflow;
  MediatText(
      { this.text = "",
        this.color = const Color(0xFF332d2b),
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
        fontSize: size ==0 ? Dimensions.font20:size,
        fontWeight: fontWeight,
      ),
    );
  }
}
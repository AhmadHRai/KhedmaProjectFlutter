import 'package:flutter/material.dart';

class IconSocialMedia extends StatelessWidget {
  final Function onTap;
  final String image;

  const IconSocialMedia({
    Key? key,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill
          ),
        ),
      ),
      onTap: () {
        onTap;
      },
    );
  }
}

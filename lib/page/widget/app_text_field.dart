import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? textController;
  final String erroeText;
  final String hintText;
  final Color hintTextColor;
  final IconData icon;
  final Color iconColor;
  final Function? valueChange;
  final TextInputType? keyboardKey;
  final bool ? obscureText;

  const AppTextField({
    Key? key,
    this.textController,
    required this.hintText,
    required this.icon,
    required this.erroeText,
    required this.hintTextColor,
    required this.iconColor,
    this.valueChange,
    this.keyboardKey,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(1, 0),
              color: Colors.grey.withOpacity(0.2),
            ),
          ]),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText!,
        keyboardType: keyboardKey,
        validator: (value) {
          if (value!.isEmpty) {
            return erroeText;
          } else {
            return null;
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hintText,
          helperStyle: TextStyle(color: hintTextColor),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(Dimensions.height20 - 10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(Dimensions.height20 - 10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(Dimensions.height20 - 10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(Dimensions.height20 - 10),
          ),
        ),
      ),
    );
  }
}

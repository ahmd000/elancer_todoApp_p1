import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
   AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hint,
    required this.prefixIcon,
  }) ;

  final TextEditingController textEditingController;
  final String hint;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: outlineBorder(),
        focusedBorder: outlineBorder(color: Colors.blueGrey)
      ),
    );
  }

  OutlineInputBorder outlineBorder({Color color = Colors.blueGrey}) {
    return OutlineInputBorder(
      borderSide:  BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

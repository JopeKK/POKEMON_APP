import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String myHintText;
  final ValueChanged onChange;

  const TextFieldWidget({
    super.key,
    required this.myHintText,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.11),
              blurRadius: 80,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: TextField(
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: myHintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skynetsecurity/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),

          onPressed: onPressed,
          child: Text(text,style: TextStyle(color: Colors.black))),
    );
  }
}

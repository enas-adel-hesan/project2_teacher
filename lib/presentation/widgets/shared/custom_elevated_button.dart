import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double fontSize;

  const CustomElevatedButton({super.key, this.onPressed, required this.title,this.fontSize=20});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
      child: Text(title,style: TextStyle(fontSize: fontSize),),
    ));
  }
}

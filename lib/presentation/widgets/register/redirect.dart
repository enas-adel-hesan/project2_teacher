import 'package:flutter/material.dart';
import 'package:teacher/core/constants/colors_manager.dart';
import 'package:teacher/core/constants/dimensions/padding.dart';
class Redirect extends StatelessWidget {
  final String title;
  final String textButton;
  final void Function()? onPressed;
  const Redirect({super.key, required this.title, required this.textButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,),
          TextButton(onPressed: onPressed, child: Text(textButton,style:TextTheme.of(context).titleLarge,))
        ],


      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';

class AppbarGobackButton extends StatelessWidget {
  const AppbarGobackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          debugPrint('뒤로가기');

          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: BikeLogColors.grey,
          size: 30,
        ));
  }
}

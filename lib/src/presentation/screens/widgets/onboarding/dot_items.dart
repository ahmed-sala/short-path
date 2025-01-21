import 'package:flutter/material.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';

class DotItems extends StatelessWidget {
  const DotItems({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: isActive ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.greyColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

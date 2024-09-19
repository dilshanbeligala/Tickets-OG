import 'package:flutter/material.dart';

import '../../../core/utils/utils_barrel.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool) onChange;
  static double size = 22;
  const AppCheckBox({super.key, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChange(!value);
      },
      child: value?Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.primaryColor[800],
            border: Border.all(
                width: 0.5,
                color: AppColors.neutralColor[300]!
            )
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(2,2,3,2),
        child: const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        ),
      ):Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
                width: 1,
                color: AppColors.neutralColor[600]!
            )
        ),
      ),
    );
  }
}

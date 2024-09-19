import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utils_barrel.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapButton;
  final Color bgColor;
  final Color textColor;
  final double? width;
  final double? radius;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool disable;
  final bool outLined;
  final int? clickDuration;
  final double? verticalPadding;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onTapButton,
    this.bgColor = const Color(0xFFFF2C37),
    this.textColor = Colors.white,
    this.width,
    this.padding,
    this.fontSize,
    this.disable = false,
    this.outLined = false,
    this.clickDuration,
    this.radius,
    this.fontWeight,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BouncingWidget(
      duration: Duration(milliseconds: clickDuration ?? 100),
      scaleFactor: 0.5,
      onPressed: () {
        if (FocusScope.of(context).isFirstFocus) {
          FocusScope.of(context).unfocus();
        }
        if (!disable) {
          onTapButton();
        }
      },
      child: Container(
        width: width ?? (padding == null ? size.width - 40 : null),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 30)),
          border: Border.all(color: disable ? AppColors.neutralColor[300]! : bgColor, width: 1),
          color: outLined ? Colors.white : disable ? AppColors.neutralColor[100] : bgColor,
        ),
        // alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(vertical: verticalPadding ?? 18),
        child: Text(buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: fontSize,
                color: disable ? AppColors.neutralColor[300] : outLined ? bgColor : textColor,
                fontWeight: fontWeight ?? FontWeight.w600,
                letterSpacing: 0.8,
                height: 1.5
            )
        ),
      ),
    );
  }
}

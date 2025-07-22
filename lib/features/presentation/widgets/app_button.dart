import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utils_barrel.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapButton;
  final List<Color>? gradientColors;
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
    this.gradientColors,
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
    final isOutlined = outLined;
    final isDisabled = disable;
    final borderColor = isDisabled
        ? AppColors.neutralColor[300]!
        : const Color(0xFFB81D24); // solid red border when outlined

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: width ?? (padding == null ? size.width - 40 : null),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          border: isOutlined ? Border.all(color: borderColor, width: 1) : null,
          gradient: !isOutlined && !isDisabled
              ? const LinearGradient(
            colors: [
              Color(0xFFB81D24),
              Color(0xFFB81D24),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isOutlined
              ? Colors.white
              : isDisabled
              ? AppColors.neutralColor[100]
              : null,
          boxShadow: !isOutlined && !isDisabled
              ? [
            BoxShadow(
              color: const Color(0xFFB81D24).withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        padding:
        padding ?? EdgeInsets.symmetric(vertical: verticalPadding ?? 18),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: fontSize,
            color: isDisabled
                ? AppColors.neutralColor[300]
                : isOutlined
                ? borderColor
                : Colors.white,
            fontWeight: fontWeight ?? FontWeight.w700,
            letterSpacing: 0.6,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

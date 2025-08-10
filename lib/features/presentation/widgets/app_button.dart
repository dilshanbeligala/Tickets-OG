
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tap_debouncer/tap_debouncer.dart';


import '../../../core/utils/utils_barrel.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapButton;
  final Color bgColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final double? fontSize;
  final bool disable;
  final bool outLined;
  final int? clickDuration;
  final double? verticalPadding;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onTapButton,
    this.bgColor = const Color(0xFFB81D24),
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
    this.disable = false,
    this.outLined = false,
    this.clickDuration,
    this.radius,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TapDebouncer(
        onTap: () async{
          if (FocusScope.of(context).isFirstFocus) {
            FocusScope.of(context).unfocus();
          }
          if (!disable) {
            onTapButton();
          }
        },
        cooldown: const Duration(seconds: 1),
        builder: (context, TapDebouncerFunc? onTap){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: width ?? (padding?.horizontal == null ? size.width - 40: null),
              height:height ,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                border: Border.all(
                    color: disable ? AppColors.neutralColor[300]! : bgColor,
                    width: 1
                ),
                color: outLined ? Colors.transparent : disable ? AppColors.primaryColor[500]!.withValues(alpha: 0.5) : bgColor,
              ),
              padding: padding ?? EdgeInsets.only(bottom: verticalPadding ?? 1.8.h, top: (verticalPadding ?? 1.8.h) - 1),
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: textColor ?? (disable ? Colors.white : outLined ? bgColor : Colors.white),
                    height: 1.25,
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

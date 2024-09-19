import 'package:flutter/material.dart';
import '../../../core/utils/enums.dart';

class AppButtonOutlined extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final bool outlined;
  final double radius;
  final double fontSize;
  final FontWeight fontWeight;
  final ButtonType buttonType;
  final Widget? prefixIcon;
  Color? textColor;
  final double verticalPadding;

  AppButtonOutlined({
    super.key,
    required this.buttonText,
    required this.onTapButton,
    this.width = 0,
    this.radius = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.prefixIcon,
    this.textColor,
    this.outlined = true,
    this.buttonType = ButtonType.ENABLED,
    this.verticalPadding = 14,
  });

  @override
  State<AppButtonOutlined> createState() => _AppButtonOutlinedState();
}

class _AppButtonOutlinedState extends State<AppButtonOutlined> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
        width: widget.width == 0 ? double.infinity : widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          border: widget.outlined
              ? Border.all(
            color: Theme.of(context).inputDecorationTheme.fillColor!,
          )
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.prefixIcon ?? const SizedBox.shrink(),
              widget.prefixIcon != null
                  ? const SizedBox(width: 5)
                  : const SizedBox.shrink(),
              Expanded(
                child: Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.buttonType == ButtonType.ENABLED
                        ? widget.textColor ??
                        Theme.of(context).textTheme.labelMedium?.color
                        : widget.textColor == null
                        ? Colors.black
                        : widget.textColor!.withAlpha(150),
                    fontWeight: widget.fontWeight,
                    fontSize: widget.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (widget.buttonType == ButtonType.ENABLED) {
          widget.onTapButton();
        }
      },
    );
  }
}

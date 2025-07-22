import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintColor;
  final double? width;
  final IconData? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool password;
  final int? maxLength;
  final int? lines;
  final bool enable;
  final bool dropdown;
  final bool bold;
  final bool dismissOnTapOutside;
  final bool onlyNumbers;
  final String? errorText;
  final TextStyle? style;

  const AppTextField({
    super.key,
    this.hintText,
    this.fillColor,
    this.textColor,
    this.hintColor,
    this.width,
    this.prefix,
    this.validator,
    this.keyboardType,
    this.controller,
    this.password = false,
    this.maxLength,
    this.enable = true,
    this.suffix,
    this.dropdown = false,
    this.lines = 1,
    this.bold = false,
    this.dismissOnTapOutside = false,
    this.errorText,
    this.style,
    required this.label,
    this.onlyNumbers = false,
  });

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.password) {
      obscureText = true;
    }
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const borderColor = Color(0xFF221F1F);

    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      width: widget.width ?? size.width - 40,
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: borderColor,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            enabled: widget.enable,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            controller: widget.controller,
            obscureText: obscureText,
            inputFormatters: [
              if (widget.onlyNumbers) FilteringTextInputFormatter.digitsOnly,
            ],
            onTapOutside: (event) {
              if (widget.dismissOnTapOutside &&
                  FocusScope.of(context).isFirstFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            decoration: InputDecoration(
              isDense: true,
              errorText: widget.errorText,
              errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 1,
                color: Colors.redAccent,
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: widget.hintColor ?? Colors.grey,
                fontWeight: FontWeight.w500,
                height: widget.lines == 1 ? 1.1 : 1.5,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.lines != 1 ? 12 : 20,
                horizontal: 16,
              ),
              counterText: "",
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              border: outlineBorder,
              enabledBorder: outlineBorder,
              focusedBorder: outlineBorder,
              disabledBorder: outlineBorder,
              errorBorder: outlineBorder.copyWith(
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              suffixIcon: widget.password
                  ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleObscureText,
              )
                  : widget.suffix,
            ),
            maxLength: widget.maxLength,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: !widget.enable
                  ? (widget.textColor ?? Colors.grey)
                  : (widget.textColor ?? borderColor),
              fontWeight: widget.bold ? FontWeight.bold : FontWeight.w500,
              height: widget.lines == 1 ? 1.1 : 1.5,
            ),
            maxLines: widget.password ? 1 : widget.lines,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}

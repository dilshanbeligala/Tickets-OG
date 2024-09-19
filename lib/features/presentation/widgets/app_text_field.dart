
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tickets_og/core/utils/utils_barrel.dart';


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

  const AppTextField({super.key, this.hintText, this.fillColor, this.textColor, this.hintColor, this.width, this.prefix, this.validator, this.keyboardType, this.controller, this.password = false, this.maxLength, this.enable = true, this.suffix, this.dropdown = false, this.lines = 1, this.bold = false, this.dismissOnTapOutside = false, this.errorText, this.style, required this.label, this.onlyNumbers = false});


  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {

  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    if(widget.password){
      obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  color: AppColors.textColor
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              enabled: widget.enable,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              controller: widget.controller,
              obscureText: obscureText,
              inputFormatters: [
                if(widget.onlyNumbers)FilteringTextInputFormatter.digitsOnly,
              ],
              onTapOutside: (event){
                if(widget.dismissOnTapOutside && FocusScope.of(context).isFirstFocus) {
                  FocusScope.of(context).unfocus();
                }
              },
              decoration: InputDecoration(
                isDense: true,
                errorText: widget.errorText,
                errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1,
                  color: AppColors.dangerColor[500],
                ),
                hintText: widget.hintText,
                suffixIcon: widget.suffix??(widget.dropdown?Container(
                  padding: const EdgeInsets.only(right: 22, top: 4, bottom: 4, left: 8),
                  child:  SvgPicture.asset(
                    AppImages.icArrowDown,
                    width: 8,
                  ),
                ):(widget.password?InkWell(
                  onTap: (){
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 18, top: obscureText?8:4, bottom: 4, left: 8),
                    child:  SvgPicture.asset(
                      obscureText?AppImages.icEyeClose:AppImages.icEyeOpen,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ):null)),
                hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: widget.hintColor??AppColors.neutralColor[600],
                    fontWeight: FontWeight.w500,
                    height: widget.lines == 1?1.1:1.5
                ),
                contentPadding: EdgeInsets.symmetric(vertical: widget.lines != 1?12:20, horizontal:16),
                counterText: "",
                filled: widget.fillColor != null,
                fillColor: widget.fillColor,
              ),
              maxLength: widget.maxLength,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: !widget.enable ? (widget.textColor ?? AppColors.neutralColor[600]) : (widget.textColor ?? AppColors.textColor),
                  fontWeight: FontWeight.w500,
                  height: widget.lines == 1?1.1:1.5
              ),
              maxLines: widget.password?1:widget.lines,
              validator: widget.validator,
            ),
          ],
        )
    );
  }
}

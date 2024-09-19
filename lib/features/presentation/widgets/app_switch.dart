
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/utils_barrel.dart';
import '../../data/models/common/common_barrel.dart';

class CustomSwitch extends StatelessWidget{
  final List<SwitchOption> options;
  final double width;
  final String selectedOption;
  final void Function(String) onClick;
  const CustomSwitch({super.key, required this.options, required this.width, required this.selectedOption, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(
                color: AppColors.neutralColor[200]!,
                width: 4
            )
        ),
        child: ListView.builder(
            itemCount: options.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Container(
                  height: 55,
                  width: (width - 8) / options.length,
                  decoration: BoxDecoration(
                    color: selectedOption == options[index].value?AppColors.primaryColor[500]:Colors.white,
                    borderRadius:(index == 0)?const BorderRadius.only(bottomLeft:Radius.circular(100), topLeft:Radius.circular(100)):(index == options.length - 1)?const BorderRadius.only(bottomRight:Radius.circular(100), topRight:Radius.circular(100)):null,
                  ),
                  child: BouncingWidget(
                      onPressed: () async{
                        await Future.delayed(const Duration(milliseconds: 400));
                        onClick(options[index].value);
                      },
                      child: Container(
                        height: 55,
                        width: (width - 8)/options.length,
                        decoration: BoxDecoration(
                          color: selectedOption == options[index].value?AppColors.primaryColor[500]:Colors.white,
                          borderRadius:(index == 0)?const BorderRadius.only(bottomLeft:Radius.circular(100), topLeft:Radius.circular(100)):(index == options.length - 1)?const BorderRadius.only(bottomRight:Radius.circular(100), topRight:Radius.circular(100)):null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              options[index].icon,
                              color: selectedOption == options[index].value?AppColors.neutralColor[50]:AppColors.neutralColor[500],
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              options[index].label,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: selectedOption == options[index].value?AppColors.neutralColor[50]:AppColors.neutralColor[500],
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      )
                  )
              );
            }
        )
    );
  }
}
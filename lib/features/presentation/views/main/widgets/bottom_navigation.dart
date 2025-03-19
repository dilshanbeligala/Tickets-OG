
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass/glass.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/data/models/common/common_barrel.dart';


import '../../../../../core/utils/utils_barrel.dart';



class BottomNavigation extends StatelessWidget {
  final int index;
  final void Function(int) onClick;
  final List<NavData> navList;
  
  const BottomNavigation({
    super.key,
    required this.index, required this.onClick,
    required this.navList,
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      margin: EdgeInsets.only(bottom: padding.bottom + 1.h, left:20, right:20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(36),
        ),
        width: 100.w - 40,
        padding: const EdgeInsets.all(8),
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: navList.map((e) {
              int i = navList.indexOf(e);
              return InkWell(
                  onTap: (){
                    onClick(i);
                  },
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: index == i ? ((100.w) - 56)/3 : 64,
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: index == i?AppColors.neutralColor[700]:null,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: (index == i)?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            e.activeIcon,
                            height: 22,
                            width: 22,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            child: Material(
                              type: MaterialType.transparency,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  e.label,
                                  maxLines: 1,
                                  minFontSize: 2,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ):SvgPicture.asset(
                        e.inActiveIcon,
                        height: 22,
                        width: 22,
                      )
                  )
              );
            }).toList(),
          ),
        ),
      ).asGlass(
        clipBorderRadius: BorderRadius.circular(36),
      ),
    );
  }
}

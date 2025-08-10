import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils_barrel.dart';


class FilterTag extends StatelessWidget {
  final String? value;
  final Function() onRemove;
  const FilterTag({super.key, this.value, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFEFE8D8),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.neutralColor[700]
              ),
            ),
            SizedBox(width: 2.w),
            InkWell(
              onTap: onRemove,
              child: SvgPicture.asset(
                AppImages.icCloseCircle,
                height: 2.5.h,
                width: 2.5.h,
              ),
            )
          ],
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils_barrel.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.8.h, right: 3.w),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(
            AppImages.icClose,
            width: 3.h,
            height: 3.h,
          ),
        ),
      ),
    );
  }
}

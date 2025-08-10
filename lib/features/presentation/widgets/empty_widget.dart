import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';


class EmptyWidget extends StatelessWidget {
  final String title;
  final String message;
  final String icon;
  const EmptyWidget({super.key, required this.title, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 6.h,
            height: 6.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEFE8D8),
            ),
            child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 3.h,
                  height: 3.h,
                )
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.34,
                color:  Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color:  Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
        ],
      ),
    );
  }
}

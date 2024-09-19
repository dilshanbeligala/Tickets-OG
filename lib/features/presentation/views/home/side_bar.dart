import 'package:class_q/features/presentation/views/home/home_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/utils_barrel.dart';


class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return SizedBox(
      height: size.height,
      width: size.width * 0.7,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SvgPicture.asset(
                      AppImages.icHomeLogo,
                      height: 15.h,
                      width: 10.w,
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          AppImages.icClose,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.7 - 48,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.icWordLogo,
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: size.width * 0.04),
                    Column(
                      children: [
                        SizedBox(
                          width: size.width* 0.66 - 72,
                          child: Text(
                            'Name',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: AppColors.neutralColor[800],
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width* 0.66 - 72,
                          child: Text(
                            'Email',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.neutralColor[800],
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SideBarLink(
                  label: "one",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Two",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Three",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Four",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Five",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Six",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: "Seven",
                  icon: AppImages.icWordLogo,
                  onClick: (){

                  }
              ),
              SideBarLink(
                  label: LocaleData.logOut.getString(context),
                  icon: AppImages.icWordLogo,
                  onClick: ()async {

                  }
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              AppImages.icDrawerBg,
              width: size.width * 0.45,
            ),
          )
        ],
      ),
    );
  }
}

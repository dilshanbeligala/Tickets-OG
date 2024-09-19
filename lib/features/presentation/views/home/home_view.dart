import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';



import '../../../../core/utils/utils_barrel.dart';

import '../base_view.dart';

import 'home_barrel.dart';


class HomePage extends BaseView {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends BaseViewState<HomePage> {
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String greeting = "";



  int liveMandalaScore = 0;
  int accuracyScore = 0;

  @override
  void initState() {
    super.initState();

    _setGreeting();

  }

  void _setGreeting() {
    final int hours = DateTime.now().hour;

    if (hours < 12) {
      greeting = "Good Morning";
    } else if (hours < 16) {
      greeting = "Good Afternoon";
    } else if (hours < 21) {
      greeting = "Good Evening";
    } else {
      greeting = "Good Night";
    }
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget buildView(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return PopScope(
        canPop: canPopNow,
        onPopInvoked: (didPop) {
          if(!_scaffoldKey.currentState!.isDrawerOpen){
            final now = DateTime.now();
            if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
              currentBackPressTime = now;
              setState(() {
                canPopNow = false;
              });
              Fluttertoast.showToast(msg: LocaleData.pressAgainToExit.getString(context));
              return;
            } else {
              setState(() {
                canPopNow = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                exit(0);
              });
            }
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
                key: _scaffoldKey,
                extendBodyBehindAppBar: true,
                drawerScrimColor: const Color(0xFF231F20).withOpacity(0.85),
                drawer: const Drawer(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: SideBar(),
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  flexibleSpace: Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: padding.top),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                            left: 20,
                            child: InkWell(
                              onTap: (){
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child:  SvgPicture.asset(
                                AppImages.icMenu,
                                height: 38,
                                width: 38,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: padding.bottom + size.height * 0.03),
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.primaryColor[50],
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02 + padding.top + kToolbarHeight,
                              width: size.width,
                            ),
                            SizedBox(
                              width: size.width - 40,
                              child: Text(
                                '$greeting,',
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    height: 1.3,
                                    color: AppColors.textColor,
                                    fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }







  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }
}

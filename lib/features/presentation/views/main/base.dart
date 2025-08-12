import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/core/utils/utils_barrel.dart';
import 'package:tickets_og/features/data/models/common/common_barrel.dart';
import 'package:tickets_og/features/presentation/views/base_view.dart';
import '../history/history_barrel.dart';
import '../scanner/scanner_barrel.dart';
import 'main_barrel.dart';

class Base extends BaseView {
  static final GlobalKey<BaseState> staticGlobalKey = GlobalKey<BaseState>();
  Base({Key? key}) : super(key: Base.staticGlobalKey);

  @override
  State<Base> createState() => BaseState();
}

class BaseState extends BaseViewState<Base> with TickerProviderStateMixin{
  DateTime? currentBackPressTime;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  late List<NavData> navData = [];
  int _previousPage = 0;
  bool hideAnimation = false;

  @override
  void initState() {
    super.initState();
    navData = [
      NavData(label: 'Home', basePage: const HomePage(), activeIcon: AppImages.icHome, inActiveIcon: AppImages.icHome),
      NavData(label: 'Scan', basePage: const ScanPage(), activeIcon: AppImages.icQr, inActiveIcon: AppImages.icQr),
      NavData(label: 'History', basePage: const HistoryPage(), activeIcon: AppImages.icHistory, inActiveIcon: AppImages.icHistory),

    ];
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (canPop, reason) async{
        DateTime now = DateTime.now();
        if(_currentPage != 0){
          if(!(await navData[_currentPage].navKey.currentState!.maybePop())){
            changeTab(0);
          }
        }else{
          if(!(await navData[_currentPage].navKey.currentState!.maybePop())){
            if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
              currentBackPressTime = now;
              showAppDialog(
                title: 'Exit App',
                message: 'Are you sure you want to exit?',
                positiveButtonText: 'Yes',
                negativeButtonText: 'No',
                onPositiveCallback: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
                },
                onNegativeCallback: () {},
              );
            }else{
              if(Platform.isAndroid){
                SystemNavigator.pop();
              }else{
                exit(0);
              }
            }
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child:  Navigator(
                  key: navData[_currentPage].navKey,
                  onGenerateRoute: (routeSettings) {
                    return MaterialPageRoute(
                      builder: (context) => navData[_currentPage].basePage,
                    );
                  },
                ),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: _currentPage > _previousPage
                        ? const Offset(1, 0) // Slide from right
                        : const Offset(-1, 0), // Slide from left
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            ),

          ],
        ),
        bottomNavigationBar: BottomNavigation(
            index: _currentPage,
            navList: navData,
            onClick: changeTab
        ),
      ),
    );
  }

  changeTab(int index){
    setState(() {
      _previousPage = _currentPage;
      _currentPage = index;
    });
  }






}
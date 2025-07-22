import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/core/utils/app_images.dart';
import '../../../../core/services/service_barrel.dart';
import '../auth/auth_barrel.dart';
import '../main/main_barrel.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  final TokenService tokenService = injection();

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  Future<void> navigationPage() async {
    if (await tokenService.checkToken()) {
      _navigate( Base());
    } else {
      await Future.delayed(const Duration(seconds: 1));
      _navigate(const LoginView());
    }
  }

  void _navigate(Widget view) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => view),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 39.h,
            child: _buildLogo(),
          ),
          Positioned(
            bottom: 3.h,
            child: _buildFooter(size),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      AppImages.icLogo1,
      height: 11.3.h,
    );
  }

  Widget _buildFooter(Size size) {
    return SizedBox(
      width: size.width - 50,
      child: Text(
        'Copyright © 2025 TicketsOG Pvt(Ltd) |\nAll Rights Reserved',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.sp,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

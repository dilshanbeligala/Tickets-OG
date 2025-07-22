import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/presentation/views/main/base.dart';
import 'package:tickets_og/features/presentation/views/main/home_view.dart';
import '../../../../core/utils/utils_barrel.dart';
import 'login_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    _navigate(Base());
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 39.h,
              child: _buildLogo(),
            ),
            // Positioned(
            //   bottom: 0,
            //   // child: _buildFooter(size, context),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFB81D24),Color(0xFFB81D24),Color(0xFFB81D24)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        'TICKETS OG',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          height: 1.71,
        ),
      ),
    );
  }

  // Widget _buildFooter(Size size, BuildContext context) {
  //   return SizedBox(
  //     width: size.width,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Container(
  //           margin: const EdgeInsets.only(bottom: 10),
  //           child: Image.asset(
  //             AppImages.icSplashBg,
  //             width: size.width,
  //             fit: BoxFit.fitWidth,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  void _navigate(view) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => view), (route) => false,);
  }
}

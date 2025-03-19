import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';
import 'package:tickets_og/features/presentation/views/auth/auth_barrel.dart';
import '../../../../../core/utils/utils_barrel.dart';
import '../../../domain/repository/repository_barrel.dart';
import '../base_view.dart';

class SplashView extends BaseView {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends BaseViewState<SplashView> with SingleTickerProviderStateMixin {
  final Repository _repository = GetIt.I<Repository>();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _startFadeOut();
  }

  Future<void> _startFadeOut() async {
    await Future.delayed(const Duration(seconds: 2));
    _controller.forward();
    await Future.delayed(const Duration(seconds: 2));
    _navigate(const LoginView());
  }

  void _navigate(view) {
    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(child: view, type: PageTransitionType.fade),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Image.asset(
                    AppImages.icSplashBg,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo (uncomment if needed)
                      // Image(
                      //   image: const AssetImage(AppImages.icLogo),
                      //   height: 30.w,
                      // ),
                    ],
                  ),
                  Positioned(
                    bottom: padding.bottom,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Powered by\n",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "TicketsOG",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                              color: AppColors.primaryColor[900],
                              fontWeight: FontWeight.w700,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

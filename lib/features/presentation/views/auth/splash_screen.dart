
import 'package:class_q/features/presentation/views/auth/auth_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/utils_barrel.dart';
import '../../../domain/repository/repository_barrel.dart';
import '../base_view.dart';

class SplashView extends BaseView {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends BaseViewState<SplashView> {
  final Repository _repository = GetIt.I<Repository>();


  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    await Future.delayed(const Duration(seconds: 2));
      _navigate(const LoginView());
  }

  void _navigate(view) {
    Navigator.of(context).pushAndRemoveUntil(
        PageTransition(child: view, type: PageTransitionType.fade),
            (route) => false);
  }

  @override
  Widget buildView(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: const AssetImage(AppImages.icLogo),
                    height: 30.w,
                  ),
                ],
              ),
              Positioned(
                bottom: padding.bottom,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Powered by\n",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.neutralColor[600],
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "TicketsOG",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor[900],
                            fontWeight: FontWeight.w700,
                            fontSize: Theme.of(context).textTheme.labelSmall?.fontSize
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

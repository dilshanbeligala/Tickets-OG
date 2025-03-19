import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import 'package:tickets_og/features/presentation/views/main/main_barrel.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/utils_barrel.dart';
import '../../../domain/usecases/auth/login.dart';
import '../../widgets/widgets_barrel.dart';
import '../base_view.dart';


class LoginView extends BaseView {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  late DateTime currentBackPressTime;
  LoginUseCase logIn = injection<LoginUseCase>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _emailController.text="s@gmail.com";
    _passwordController.text="112";
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: LocaleData.pressAgainToExit.getString(context));
      return Future.value(false);
    }
    return Future.value(true);
  }

  // Future<void> _signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     showProgressBar();
  //     final request = LoginRequest(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //     final result = await logIn.call(Params([request]));
  //     if (!mounted) return;
  //     hideProgressBar();
  //     result.fold((failure) {
  //       handleErrors(failure: failure);
  //     }, (user) async {
  //       await secureStorage.write(key: 'user', value: user.toString());
  //       if (mounted) {
  //         user.success==true?
  //         Navigator.of(context).pushAndRemoveUntil(
  //             PageTransition(child: const HomePage(), type: PageTransitionType.fade),
  //                 (route) => false):
  //              showCustomBottomSheet(
  //               title: LocaleData.loginFailed.getString(context),
  //               subtitle:user.message!,
  //               alertType: AlertType.SUCCESS,
  //               onTapButton: (){
  //               Navigator.of(context).pop();
  //               },
  //               buttonText: LocaleData.ok.getString(context)
  //         );
  //       }
  //     },
  //     );
  //   }
  // }

  @override
  Widget buildView(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: padding.top,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Lottie.asset(
                          AppAnimations.qr,
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: size.width - 40,
                          child: Text(
                            LocaleData.signInTO.getString(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        AppTextField(
                            label: LocaleData.userName.getString(context),
                            hintText: LocaleData.emailHint.getString(context),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: Validator.validateEmail),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextField(
                            label: LocaleData.password.getString(context),
                            hintText:
                                LocaleData.passwordHint.getString(context),
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            password: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can\'t be empty';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: padding.bottom + 12,
                    child: Column(
                      children: [
                        AppButton(
                          buttonText: LocaleData.login.getString(context),
                          onTapButton: () {
                            if (_formKey.currentState!.validate()) {
                              _navigateToHome();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) =>  Base()), (route) => false);
  }
}

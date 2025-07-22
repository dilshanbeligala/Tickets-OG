import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/core/utils/app_images.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../error/error_barrel.dart';
import '../../../data/models/request/request_barrel.dart';
import '../../../domain/usecases/usecase_barrel.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../base_view.dart';
import '../main/base.dart';

class LoginView extends BaseView {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends BaseViewState<LoginView>
    with SingleTickerProviderStateMixin {
  DateTime? currentBackPressTime;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  LoginUseCase logIn = injection<LoginUseCase>();
  String? error;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
      canPop: currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) > const Duration(seconds: 2),
      onPopInvoked: (didPop) {
        if (!didPop) {
          currentBackPressTime = DateTime.now();
          Fluttertoast.showToast(msg: "Press back again to exit");
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF0E0E0E),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB81D24), // Bright red
                Color(0xFF0E0E0E), // Dark black
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title at top
                Container(
                  height: 40.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "LOGO",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Login Form
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h),
                            Text(
                              "Welcome Back 🤘",
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              controller: _userNameController,
                              keyboardType: TextInputType.emailAddress,
                              label: "Email or Phone Number",
                              hintText: "Enter Your Email or Phone Number",
                            ),
                            SizedBox(height: 3.h),
                            AppTextField(
                              controller: _passwordController,
                              label: "Password",
                              password: true,
                              hintText: "Enter Your Password",
                            ),
                            SizedBox(height: 4.h),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: AppButton(
                    onTapButton: _signIn,
                    buttonText: "Login",
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }



  Future<void> _signIn() async {
    setState(() => error = null);
    if (_formKey.currentState!.validate()) {
      showProgressBar();
      final request = LoginRequest(
          username: _userNameController.text,
          password:_passwordController.text,
      );
      final result = await logIn.call(Params([request]));
      if (!mounted) return;
      hideProgressBar();
      result.fold((failure){
        if (failure is AuthorizedFailure) {
          setState(() => error = '${failure.errorResponse.errorDescription}');
        } else if (failure is ServerFailure){
          if(failure.errorResponse.errorCode != '400') {
            setState(() => error = '${ErrorHandler().mapFailureToTitleAndMessage(failure)['message']}');
          }
        }
      }, (user) async {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(PageTransition(child: Base(), type: PageTransitionType.fade), (route) => false);
        }
      });
    }
  }
}

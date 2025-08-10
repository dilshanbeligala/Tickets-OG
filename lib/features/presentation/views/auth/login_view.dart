import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
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
  void initState() {
    super.initState();
    _userNameController.text = 'sandy12345';
    _passwordController.text = 'Password@123';
  }

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
      canPop: currentBackPressTime != null &&
          DateTime.now().difference(currentBackPressTime!) >
              const Duration(seconds: 2),
      onPopInvokedWithResult: (bool didPop, result) {
        if (!didPop) {
          currentBackPressTime = DateTime.now();
          // Fluttertoast.showToast(msg: "Press again to exit");
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.h,
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    AppImages.icLogo1,
                    height: 11.3.h,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF221F1F),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          AppTextField(
                            controller: _userNameController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email or Phone Number",
                            hintText: "Enter Your Email or Phone Number",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email or phone number is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 3.h),
                          AppTextField(
                            controller: _passwordController,
                            label: "Password",
                            password: true,
                            hintText: "Enter Your Password",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 4.h),
                          if (error != null)
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Text(
                                error!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 11.sp),
                              ),
                            ),
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

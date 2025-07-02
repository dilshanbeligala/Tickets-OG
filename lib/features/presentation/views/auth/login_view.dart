import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/core/utils/app_images.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
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
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Image with Gradient
              Stack(
                children: [
                  Image.asset(
                    AppImages.icLogin,
                    height: 40.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 15.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFF0E0E0E),
                            const Color(0xFF0E0E0E).withOpacity(0.9),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
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
                              color:  Colors.white,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          AppTextField(
                            controller: _emailController,
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
                padding:  EdgeInsets.only(bottom: 5.h),
                child: AppButton(
                  onTapButton: () {
                    _navigate(context, Base());
                  },
                  buttonText: "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget view) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => view),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import 'package:tickets_og/features/presentation/views/auth/auth_barrel.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/utils_barrel.dart';
import '../../../data/models/request/request_barrel.dart';
import '../../widgets/widgets_barrel.dart';
import '../base_view.dart';

class ResetPasswordView extends BaseView {
  final String resetToken;
  final String email;
  const ResetPasswordView({super.key,required this.email,required this.resetToken});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends BaseViewState<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _conformPasswordController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  late DateTime currentBackPressTime;
  ResetUseCase reset = injection<ResetUseCase>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }



  Future<void> _reset() async {
    if (_formKey.currentState!.validate()) {
      showProgressBar();
      final request = ResetRequest(
        resetToken: widget.resetToken,
        email: widget.email,
        newPassword: _conformPasswordController.text
      );
      final result = await reset.call(Params([request]));
      if (!mounted) return;
      hideProgressBar();
      result.fold((failure) {
        handleErrors(failure: failure);
      }, (user) async {
        await secureStorage.write(key: 'user', value: user.toString());
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(child: const LoginView(), type: PageTransitionType.fade),
                  (route) => false);
        }
      },
      );
    }
  }

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
                        SvgPicture.asset(
                          AppImages.icCircleLogo,
                          height: size.height * 0.25,
                        ),
                        SizedBox(
                          width: size.width - 40,
                          child: Text(
                            LocaleData.resetPassword.getString(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor
                            ),
                          ),
                        ),

                        SizedBox(
                            height: 6.h
                        ),
                        AppTextField(
                          label: LocaleData.newPassword.getString(context),
                          hintText: LocaleData.passwordHint.getString(context),
                          keyboardType: TextInputType.emailAddress,
                          controller: _newPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleData.passwordCantEmpty.getString(context);
                            } else if (_newPasswordController.text != _conformPasswordController.text) {
                              return LocaleData.passwordsDidnt.getString(context);
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextField(
                          label: LocaleData.confirmPassword.getString(context),
                          hintText: LocaleData.passwordHint.getString(context),
                          keyboardType: TextInputType.text,
                          controller: _conformPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleData.passwordCantEmpty.getString(context);
                            } else if (_newPasswordController.text != _conformPasswordController.text) {
                              return LocaleData.passwordsDidnt.getString(context);
                            }
                            return null;
                          },
                        ),


                      ],
                    ),
                  ),
                  Positioned(
                    bottom: padding.bottom + 12,
                    child: AppButton(
                      buttonText: LocaleData.resetPassword.getString(context),
                      onTapButton: _reset,
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}

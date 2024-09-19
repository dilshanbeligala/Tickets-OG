import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import 'package:tickets_og/features/presentation/views/auth/auth_barrel.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/utils_barrel.dart';
import '../../widgets/widgets_barrel.dart';
import '../base_view.dart';

class MailOtpView extends BaseView {
  const MailOtpView({super.key});

  @override
  MailOtpViewState createState() => MailOtpViewState();
}

class MailOtpViewState extends BaseViewState<MailOtpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  RecoverUseCase recover = injection<RecoverUseCase>();

  @override
  void initState() {
    super.initState();
  }
  Future<void> _recover() async {
    if (_formKey.currentState!.validate()) {
      showProgressBar();
      final request = RecoverRequest(
          email: _emailController.text,
      );
      final result = await recover.call(Params([request]));
      hideProgressBar();
      result.fold((failure) {
        handleErrors(failure: failure);
      }, (response) {
        Navigator.of(context).push(PageTransition(child:  OtpView(email: _emailController.text), type: PageTransitionType.fade));
      },
      );
    }
  }


  @override
  Widget buildView(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                        height: 8.h,
                      ),
                      SvgPicture.asset(
                        AppImages.icCircleLogo,
                        height: size.height * 0.08,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: size.width - 40,
                        child: Text(
                          LocaleData.forgotPasswordTitle.getString(context),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 9.h
                      ),
                      AppTextField(
                        label: LocaleData.email.getString(context),
                        hintText: LocaleData.emailHint.getString(context),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: Validator.validateEmail,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: padding.top + size.height * 0.01, bottom: 12),
                    width: size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              AppImages.icBack,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: (){

                            },
                            child: SvgPicture.asset(
                              AppImages.icCallBtn,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: padding.bottom + 12,
                  child: Column(
                    children: [
                      AppButton(
                        buttonText: LocaleData.requestOtp.getString(context),
                        onTapButton: _recover,
                      ),
                    ],
                  ),
                )

              ],
            ),
          )
      ),
    );
  }
}

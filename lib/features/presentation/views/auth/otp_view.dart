import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/domain/usecases/usecase_barrel.dart';
import 'package:tickets_og/features/presentation/views/auth/reset_password.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/utils_barrel.dart';
import '../base_view.dart';

class OtpView extends BaseView {
  final String email;
  const OtpView({super.key,required this.email});

  @override
  OtpViewState createState() => OtpViewState();
}

class OtpViewState extends BaseViewState<OtpView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  VerifyOtpUseCase verify = injection<VerifyOtpUseCase>();
  RecoverUseCase recover = injection<RecoverUseCase>();


  @override
  void initState() {
    super.initState();
  }



  // Future<void> _verify() async {
  //   if (_formKey.currentState!.validate()) {
  //     showProgressBar();
  //     final request = VerifyOtpRequest(
  //       email: widget.email,
  //       otp: _otpController.text
  //     );
  //     final result = await verify.call(Params([request]));
  //     hideProgressBar();
  //     result.fold((failure) {
  //       handleErrors(failure: failure);
  //     }, (response) {
  //       Navigator.of(context).push(PageTransition(child:  ResetPasswordView(resetToken: response.data!.resetToken!, email: widget.email,), type: PageTransitionType.fade));
  //     },
  //     );
  //   }
  // }

  Future<void> _recover() async {
    if (_formKey.currentState!.validate()) {
      showProgressBar();
      final request = RecoverRequest(
        email: widget.email,
      );
      final result = await recover.call(Params([request]));
      hideProgressBar();
      result.fold((failure) {
        handleErrors(failure: failure);
      }, (response) {
        showCustomBottomSheet(
            title: LocaleData.resendSuccess.getString(context),
            subtitle:"",
            alertType: AlertType.SUCCESS,
            onTapButton:(){ Navigator.pop(context);},
            buttonText: LocaleData.ok.getString(context)
        );
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
                          LocaleData.otpVerification.getString(context),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 4.h
                      ),
                      SizedBox(
                        width: size.width - 40,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeColor: AppColors.neutralColor[600],
                            disabledColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            selectedColor: AppColors.primaryColor[300],
                            selectedFillColor:Colors.white,
                            inactiveColor: AppColors.neutralColor[600]
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          controller: _otpController,
                          textStyle: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          onCompleted: (value) {

                          },
                          onChanged: (value) {
                            setState(() {
                              _otpController.text = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                      SizedBox(
                          height: 4.h
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: LocaleData.didntReceive.getString(context),
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF002729),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: LocaleData.requestOtp.getString(context),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                _recover();
                                _otpController.clear();
                              } ,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: const Color(0xFF002729),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/utils_barrel.dart';
import '../../../error/error_barrel.dart';
import '../widgets/widgets_barrel.dart';


abstract class BaseView extends StatefulWidget {
  const BaseView({super.key});
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  bool _isProgressShow = false;


  Widget buildView(BuildContext context);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: buildView(context),
      ),
    );
  }

  Future openBottomSheet({required Widget page, double? maxHeight, Color? barrierColor}){
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      constraints: BoxConstraints(
          maxHeight: maxHeight??90.h
      ),
      barrierColor: barrierColor??Color(0xFF0A0A0A).withValues(alpha: 0.8),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: page,
        );
      },
    );
  }

  showAppDialog({required String title,
    String? message,
    Color? messageColor,
    String? subDescription,
    Color? subDescriptionColor,
    String? positiveButtonText,
    String? negativeButtonText,
    String? bottomButtonText,
    VoidCallback? onPositiveCallback,
    VoidCallback? onNegativeCallback,
    VoidCallback? onBottomButtonCallback,
    Widget? dialogContentWidget,
    bool shouldDismiss = false,
    bool? shouldEnableClose,
    bool isSessionTimeout = false,
    bool isAlertTypeEnable = true}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: shouldDismiss,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
                bottomButtonText: bottomButtonText,
                onBottomButtonCallback: onBottomButtonCallback,
                isAlertTypeEnable: isAlertTypeEnable,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }

  showProgressBar() {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    alignment: FractionalOffset.center,
                    child: Wrap(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child:  SpinKitRipple(
                            borderWidth: 12,
                            size: 80,
                            color:AppColors.primaryColor[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  void hideProgressBar() {
    if (_isProgressShow) {
      Navigator.of(context, rootNavigator: true).pop();
      _isProgressShow = false;
    }
  }

  void showCustomBottomSheet({
    required String title,
    required String subtitle,
    required AlertType alertType,
    required VoidCallback onTapButton,
    required String buttonText,
  }) {
    IconData icon;

    switch (alertType) {
      case AlertType.NETWORK_ERROR:
        icon = Icons.wifi_off;
        break;
      case AlertType.SERVER_ERROR:
        icon = Icons.error;
        break;
      case AlertType.AUTHENTICATION_ERROR:
        icon = Icons.lock;
        break;
      case AlertType.SUCCESS:
        icon = Icons.check_circle;
        break;
      case AlertType.WARNING:
        icon = Icons.warning;
        break;
      case AlertType.INFO:
        icon = Icons.info;
        break;
      case AlertType.DETAILS:
        icon = Icons.details;
        break;
      case AlertType.FAIL:
      default:
        icon = Icons.error;
        break;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 32),
                child: Center(
                  child: Container(
                    width: 64,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
              Icon(
                icon,
                size: 48,
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                buttonText: buttonText,
                onTapButton: onTapButton,
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  void handleErrors({required Failure failure}) {
    String errorTitle;
    String errorDescription;
    final errorHandler = ErrorHandler();
    final errorDetails = errorHandler.mapFailureToTitleAndMessage(failure);

    errorTitle = errorDetails['title'] ?? 'Unexpected Error';
    errorDescription = errorDetails['message'] ?? 'An unexpected error occurred. Please try again later.';

    showCustomBottomSheet(
      title: errorTitle,
      subtitle: errorDescription,
      alertType: AlertType.FAIL,
      onTapButton: () {
        Navigator.of(context).pop();
      },
      buttonText: "Try Again",
    );
  }
}

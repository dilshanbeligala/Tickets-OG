import 'dart:ui';

import 'package:flutter/material.dart';

import 'widgets_barrel.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final Color? descriptionColor;
  final String? subDescription;
  final Color? subDescriptionColor;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositiveCallback;
  final VoidCallback? onNegativeCallback;
  final Widget? dialogContentWidget;
  final VoidCallback? onBottomButtonCallback;
  final String? bottomButtonText;

  final bool? isSessionTimeout;

  final bool? isAlertTypeEnable;

  AppDialog(
      {required this.title,
        this.description,
        this.descriptionColor,
        this.subDescription,
        this.subDescriptionColor,
        this.onPositiveCallback,
        this.onNegativeCallback,
        this.positiveButtonText,
        this.negativeButtonText,
        this.dialogContentWidget,
        this.isSessionTimeout,
        this.bottomButtonText,
        this.onBottomButtonCallback,
        this.isAlertTypeEnable});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            alignment: FractionalOffset.center,
            padding: const EdgeInsets.all(24),
            child: Wrap(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(8),
                  child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          dialogContentWidget != null
                              ? Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 9, right: 9),
                            child: dialogContentWidget,
                          )
                              : const SizedBox(),
                          description != null
                              ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              description ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                descriptionColor ?? Colors.black,
                              ),
                            ),
                          )
                              : const SizedBox(),
                          subDescription != null
                              ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              subDescription ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: subDescriptionColor ??
                                    Colors.black,
                              ),
                            ),
                          )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                negativeButtonText != null
                                    ? Expanded(
                                  child: AppButton(
                                    buttonText: negativeButtonText!,
                                    outLined: true,
                                    onTapButton: () {
                                      Navigator.pop(context);
                                      if (onNegativeCallback !=
                                          null) {
                                        onNegativeCallback!();
                                      }
                                    },
                                  ),
                                )
                                    : const SizedBox.shrink(),
                                negativeButtonText != null
                                    ? const SizedBox(
                                  width: 31,
                                )
                                    : const SizedBox.shrink(),
                                negativeButtonText != null
                                    ? Expanded(
                                  child: AppButton(
                                    bgColor: const Color(0xFF221F1F),
                                    buttonText:
                                    positiveButtonText ?? "OK",
                                    onTapButton: () {
                                      Navigator.pop(context);
                                      if (onPositiveCallback !=
                                          null) {
                                        onPositiveCallback!();
                                      }
                                    },
                                  ),
                                )
                                    : Expanded(
                                  child: AppButton(
                                    bgColor: const Color(0xFF221F1F),
                                    buttonText:
                                    positiveButtonText ?? "OK",
                                    onTapButton: () {
                                      Navigator.pop(context);
                                      if (onPositiveCallback !=
                                          null) {
                                        onPositiveCallback!();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bottomButtonText != null
                              ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              if (onBottomButtonCallback != null) {
                                onBottomButtonCallback!();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, bottom: 8),
                              child: Text(
                                bottomButtonText ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                          )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }
}

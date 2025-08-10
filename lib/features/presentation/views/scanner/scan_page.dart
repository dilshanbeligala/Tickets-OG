import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../error/error_barrel.dart';
import '../../../data/models/request/request_barrel.dart';
import '../../../domain/usecases/usecase_barrel.dart';
import '../base_view.dart';
import 'scanner.dart';

class ScanPage extends BaseView {
  const ScanPage({super.key});

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends BaseViewState<ScanPage> {
  final codeController = TextEditingController();
  ScanUseCase checkInUseCase = injection();
  Barcode? result;
  BarcodeCapture? capture;
  bool found = false;
  Size size = Size.zero;

  Future<void> onDetect(BarcodeCapture barcode) async {
    if (!found) {
      found = true;
      capture = barcode;
      setState(() {
        result = barcode.barcodes.first;
        if (result != null) {
          verify('${result?.displayValue!}');
        }
      });
    }
  }

  verify(String code) async {
    showProgressBar();

    final apiResult = await checkInUseCase.call(Params([QrRequest(qrData: code)]));
    hideProgressBar();

    apiResult.fold(
          (failure) {
        FlutterBeep.beep();
        showAppDialog(
          title: 'Scan Failed',
          message: ErrorHandler()
              .mapFailureToTitleAndMessage(failure)['message'] ??
              'Something went wrong.',
          onPositiveCallback: () {
            setState(() {
              found = false;
              result = null;
            });
          },
        );
      },
          (success) {
        success.statusCode == "000023"
            ? FlutterBeep.beep()
            : FlutterBeep.beep(false);
        showAppDialog(
          messageColor: success.statusCode == "000022"
              ? Colors.green
              : Colors.red,
          isAlertTypeEnable: true,
          title: 'Successfully Scanned',
          message: success.message,
          onPositiveCallback: () {
            setState(() {
              found = false;
              result = null;
            });
          },
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget buildView(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Scanner(
                  onDetect: onDetect,
                ),
              ),
              Positioned(
                top: 80,
                child: Column(
                  children: [
                  Image.asset(
                  AppImages.icLogo1,
                  height: 11.3.h,
                ),
                    const SizedBox(height: 10),
                    const Text(
                      "Scan Your Ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

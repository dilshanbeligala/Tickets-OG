import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../base_view.dart';
import 'scanner.dart';

class ScanPage extends BaseView {
  const ScanPage({super.key});

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends BaseViewState<ScanPage>{
  final codeController = TextEditingController();
  // CheckInUseCase checkInUseCase = injection();
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
        if(result != null){
          // verify('${result?.displayValue!}');
        }
      });
    }
  }

  // verify(String code) async {
  //   showProgressBar();
  //   final apiResult = await checkInUseCase.call(Params([CheckInRequest(fitnessCenterId: code)]));
  //   hideProgressBar();
  //   apiResult.fold((l){
  //     FlutterBeep.beep(false);
  //     showAlertPage(
  //         type: AlertType.WARNING,
  //         title: 'Check-In',
  //         message: '${ErrorHandler().mapFailureToTitleAndMessage(l)['message']}',
  //         positiveBtnText: 'Re-scan',
  //         onContinue: (){
  //           Navigator.of(context, rootNavigator: true).pop();
  //           found = false;
  //         }
  //     );
  //   }, (r){
  //     FlutterBeep.beep();
  //     showAlertPage(
  //         type: AlertType.SUCCESS,
  //         title: 'Attendance Recorded!',
  //         message: 'Your attendance has been successfully recorded, and the door is now unlocked. Welcome to the gym!',
  //         onContinue: (){
  //           Navigator.of(context, rootNavigator: true).pop();
  //           found = false;
  //           Base.staticGlobalKey.currentState!.changeTab(0);
  //         }
  //     );
  //   });
  // }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget buildView(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Scanner(
                  onDetect: onDetect,
                ),
              ],
            )
          ),
        ),
    );
  }
}


import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/utils_barrel.dart';
import 'scanner_barrel.dart';


class Scanner extends StatefulWidget {
  final Function(BarcodeCapture) onDetect;
  const Scanner({super.key, required this.onDetect});

  @override
  ScannerState createState() {
    return ScannerState();
  }
}

class ScannerState extends State<Scanner>{

  MobileScannerController cameraController = MobileScannerController();
  bool cameraPause = false;
  bool flashOn = false;

  @override
  void initState() {
    cameraController.stop();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.topCenter(Offset(0, size.height*0.42 + 50)),
      width: (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? size.width - 40 : size.width * 0.7,
      height: size.height * 0.38,
    );
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.92 - padding.top,
              child: MobileScanner(
                fit: BoxFit.fitHeight,
                scanWindow: scanWindow,
                controller: cameraController,
                errorBuilder: (_, __, ___){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(!cameraPause)SizedBox(
                        width: size.width*0.5,
                        child: Text(
                          '${__.errorDetails?.message}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              height: 1.6
                          ),
                        ),
                      ),
                      if(!cameraPause)BouncingWidget(
                          onPressed: () async {
                            await cameraController.start();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 32,
                            ),
                          )
                      )
                    ],
                  );
                },
                onDetect: widget.onDetect,
                overlayBuilder: (context, constraints){
                  return QRScannerOverlay(overlayColour: Colors.black.withValues(alpha: 0.6));
                },
              ),
            ),
            Positioned(
              bottom: 20.h,
              child:Column(
                children: [
                  BouncingWidget(
                    onPressed: () async{
                      cameraController.toggleTorch().then((v){
                        setState(() {
                          flashOn = !flashOn;
                        });
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 48,
                      decoration: BoxDecoration(
                        color: flashOn?Colors.white:AppColors.neutralColor[500],
                        borderRadius: BorderRadius.circular(200)
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/toach.svg',
                      ),
                    ),
                  ),
                ],
              )
            )
          ],
        )
    );
  }
}
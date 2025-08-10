import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../core/utils/app_images.dart';
import '../../widgets/history_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime? currentBackPressTime;
  bool canPopNow = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPopNow,
      onPopInvoked: (didPop) {
        final now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          setState(() => canPopNow = false);
          // Fluttertoast.showToast(msg: "Press back again to exit");
        } else {
          setState(() => canPopNow = true);
          WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D0D0D),
                  Color(0xFF3B0A55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  _buildHeader(), // FIXED header here
                  SizedBox(height: 1.h),
                  // Expanded makes scrollable take all remaining space
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Column(
                        children: [
                          _buildTotalStatsCard(75.0, 150, 120),
                          _buildHistorySection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.icLogin, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Text("UN"),
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Event Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold)),
                        Text("User Name",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 10.sp)),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.dark_mode, color: Colors.white, size: 26),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalStatsCard(double progressValue, int totalTickets, int scannedTickets) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.transparent, // subtle transparent card background
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent, // transparent background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      startAngle: 270,
                      endAngle: 270,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.15,
                        color: Colors.black,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: progressValue,
                          width: 0.15,
                          sizeUnit: GaugeSizeUnit.factor,
                          gradient: SweepGradient(
                            colors: [Colors.purpleAccent.shade200, Colors.deepPurpleAccent],
                            stops: const [0.25, 1.0],
                          ),
                          cornerStyle: CornerStyle.bothCurve,
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          positionFactor: 0.1,
                          angle: 90,
                          widget: Text(
                            "${progressValue.toInt()}%",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total Tickets',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple.shade200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalTickets',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Scanned',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple.shade200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$scannedTickets',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Scanned History",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            SizedBox(height: 1.h),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return const Column(
      children: [
        HistoryItemWidget(
          time: "5.00 pm",
          ticketNumber: "1245Abc",
          category: "VIP",
          status: "Success",
          scannedPerson: "Chamika",
          nic: "981371763V",
          seatNo: "10A",
        ),
        HistoryItemWidget(
          time: "5.01 pm",
          ticketNumber: "1245Abd",
          category: "VIP",
          status: "Failed",
          scannedPerson: "Chamika",
          nic: "981371764V",
          seatNo: "10B",
        ),
        HistoryItemWidget(
          time: "5.02 pm",
          ticketNumber: "1245Abe",
          category: "VIP",
          status: "Failed",
          scannedPerson: "Chamika",
          nic: "981371765V",
          seatNo: "10C",
        ), HistoryItemWidget(
          time: "5.02 pm",
          ticketNumber: "1245Abe",
          category: "VIP",
          status: "Failed",
          scannedPerson: "Chamika",
          nic: "981371765V",
          seatNo: "10C",
        ),
      ],
    );
  }





}


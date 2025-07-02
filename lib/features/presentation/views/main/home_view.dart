import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/core/utils/app_images.dart';
import 'package:tickets_og/features/presentation/widgets/history_widget.dart';

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
    final padding = MediaQuery.of(context).padding;

    return PopScope(
      canPop: canPopNow,
      onPopInvoked: (didPop) {
        final now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          setState(() => canPopNow = false);
          Fluttertoast.showToast(msg: "Press back again to exit");
        } else {
          setState(() => canPopNow = true);
          WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Column(
              children: [
                SizedBox(height: padding.top + 1.5.h),
                _buildHeader(),
                SizedBox(height: 2.h),
                _buildTotalStatsCard(),
                _buildCategoryStatsCard(),
                SizedBox(height: 2.h),
                _buildHistorySection(),
              ],
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
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.icLogin, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 5.0),
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
                                color: Colors.white,
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


  Widget _buildTotalStatsCard() {
    double progressValue = 0.60;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Tickets - 1000",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text("Scanned - ${(progressValue * 100).toInt()}%",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStatsCard() {
    double progressValue = 0.60;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 3.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LinearProgressIndicator(
                    minHeight: 3.h,
                    value: progressValue,
                    backgroundColor: Colors.transparent,
                    color: Colors.purpleAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text("See All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10.sp)),
              ),
            ),
            SizedBox(height: 1.h),
            // Horizontal Scrollable Circular Indicators
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                child: Row(
                  children: [
                    _buildCircularIndicator("67%", "General"),
                    SizedBox(width: 4.w),
                    _buildCircularIndicator("43%", "VIP"),
                    SizedBox(width: 4.w),
                    _buildCircularIndicator("32%", "Giveaways"),
                    SizedBox(width: 4.w),
                    _buildCircularIndicator("28%", "Backstage"),
                    SizedBox(width: 4.w),
                    _buildCircularIndicator("15%", "Guest"),
                    SizedBox(width: 4.w),
                    _buildCircularIndicator("15%", "Guest"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIndicator(String value, String label) {
    final progress = double.tryParse(value.replaceAll('%', '')) ?? 0;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
             height: 8.h,
              width: 16.w,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                value: progress / 100,
                color: Colors.purpleAccent,
                strokeWidth: 9,

              ),
            ),
            Text(value,
                style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(label,
            style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ],
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
                Row(
                  children: [
                    Text("See All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10.sp)),
                    const Icon(Icons.expand_more, size: 18),
                  ],
                ),
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
    return Column(
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

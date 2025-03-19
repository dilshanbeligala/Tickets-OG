import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return PopScope(
      canPop: canPopNow,
      onPopInvoked: (didPop) {
        final now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          setState(() => canPopNow = false);
          Fluttertoast.showToast(msg: "Press again to exit");
        } else {
          setState(() => canPopNow = true);
          WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          // backgroundColor: Colors.grey[400],
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: padding.bottom + size.height * 0.03),
            child: Column(
              children: [

                Padding(
                  padding:  EdgeInsets.only(top:padding.top + 10 ),
                  child: _buildHeader(context),
                ),
                _buildStatsCard(),
                _buildHistorySection(),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration:  BoxDecoration(
          image:DecorationImage(image:AssetImage(AppImages.icHomeBg,),fit: BoxFit.cover) ,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 25, backgroundColor: Colors.white, child: Text("UN")),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Event Name", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
                Text("User Name", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.dark_mode, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    double progressValue = 0.60; // You can change this value dynamically

    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.red, width: 2), // Red border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Tickets - 1000",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'Scanned - ${(progressValue * 100).toInt()}%', // Display percentage at the end
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 30, // Increased height for the progress bar container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Rounded corners for the container
                color: Colors.grey.shade300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Apply the radius to the filling as well
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0), // Padding to move the text inside the progress
                      child: Text(
                        '${(progressValue * 100).toInt()}%', // Display percentage at the end
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      minHeight: 30, // Increased height for the progress bar itself
                      value: progressValue,
                      backgroundColor: Colors.transparent,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Action for "See All" (if any)
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "See All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12
                      ),
                    ),
                    const Icon(Icons.expand_more, color: Colors.black, size: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircularIndicator("67%", "General"),
                _buildCircularIndicator("43%", "VIP"),
                _buildCircularIndicator("32%", "Giveaways"),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildHistorySection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.black, width: 2), // Red border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Scanned History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12
                      ),
                    ),
                    const Icon(Icons.expand_more, color: Colors.black, size: 15),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildHistory(),

          ],
        ),
      ),
    );
  }

  Widget _buildCircularIndicator(String value, String label) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: 50, width: 50, child: CircularProgressIndicator(value: double.parse(value.replaceAll('%', '')) / 100,color: Colors.black,strokeWidth: 6,)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
          ],
        ),
        Text(label, style: const TextStyle(fontSize: 14,color: Colors.red)),
      ],
    );
  }

  Widget _buildHistory() {
    return Column(
      children: [
        HistoryItemWidget(time: "5.00 pm", ticketNumber: "1245Abc", category: "VIP", status: "Success", scannedPerson: "Chamika",nic: "981371763V",seatNo: "10A",),
        HistoryItemWidget(time: "5.00 pm", ticketNumber: "1245Abc", category: "VIP", status: "Failed", scannedPerson: "Chamika",nic: "981371763V",seatNo: "10A"),
        HistoryItemWidget(time: "5.00 pm", ticketNumber: "1245Abc", category: "VIP", status: "Failed", scannedPerson: "Chamika",nic: "981371763V",seatNo: "10A"),
        HistoryItemWidget(time: "5.00 pm", ticketNumber: "1245Abc", category: "VIP", status: "Failed", scannedPerson: "Chamika",nic: "981371763V",seatNo: "10A"),
      ],
    );

  }


  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.red,), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code,color: Colors.black,size: 30,), label: "Scan"),
        BottomNavigationBarItem(icon: Icon(Icons.history_outlined,color: Colors.black,), label: "History"),
      ],
    );
  }
}

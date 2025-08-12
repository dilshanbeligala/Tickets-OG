
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets_og/features/data/models/response/get_ticket_history.dart';
import '../../widgets/widgets_barrel.dart';

class BookingDetailsSheet extends StatefulWidget {
  final TicketDetails ticket;
  const BookingDetailsSheet({super.key,
    required this.ticket,
  });

  @override
  BookingDetailsSheetState createState() {
    return BookingDetailsSheetState();
  }
}

class BookingDetailsSheetState extends State<BookingDetailsSheet> {
  Size bottomSection = Size.zero;
  late TicketDetails ticket;

  @override
  void initState() {
    super.initState();
    ticket = widget.ticket;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            maxHeight: 90.h
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        width: 100.w,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 2.5.h),
                    _buildTitleText(),
                    SizedBox(height: 2.5.h),
                    _buildData(title: 'Event Name', data: '${ticket.eventName}'),
                    _buildData(title: 'Ticket ID', data: '${ticket.ticketId}'),
                    _buildData(title: 'Verify ID', data: '${ticket.verifyId}'),
                    _buildData(title: 'Ticket Category', data: '${ticket.eventCategory}'),
                    _buildData(
                      title: 'Price',
                      data: '${NumberFormat('#,##0.00').format(ticket.price)} Rs',
                    ),
                    _buildData(title: 'Name', data:'${ticket.userName}'),
                    _buildData(title: 'Scanned Date', data:'${ticket.scanDate}'),
                    _buildData(
                      title: 'Scanned Time',
                      data: _formatTime(ticket.scanTime),
                    ),
                    SizedBox(height: bottomSection.height + 3.h),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }


  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return '';
    try {
      final time = DateFormat.Hms().parse(timeString);
      return DateFormat.jm().format(time);
    } catch (e) {
      return timeString;
    }
  }


  _buildHeader() {
    return const BottomSheetHeader();
  }

  _buildTitleText (){
    return SizedBox(
        width: 100.w - 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Scanned Ticket Details",
                  style: GoogleFonts.libreBaskerville(
                    textStyle:  Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.75,
                      color: const Color(0xFF1B1B1B),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }


  _buildData({required String title, required String data, bool border = true}){
    return Container(
      decoration: BoxDecoration(
        border: border?const Border(
          bottom: BorderSide(
            color: Color(0xFFF2F2F2),
          )
        ):null
      ),
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        children: [
          SizedBox(
            width: 100.w - 40,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          SizedBox(
            width: 100.w - 40,
            child: Text(
              data,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/response/response_barrel.dart';


class HistoryCard extends StatelessWidget {
  final TicketDetails ticket;
  final VoidCallback? onCardClick;


  const HistoryCard({
    super.key,
    this.onCardClick,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onCardClick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildID(context),
                      SizedBox(height: 0.5.h),
                      _buildHeader(context),
                      SizedBox(height: 0.5.h),
                      _buildTime(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${ticket.userName}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
        Text(
          '${ticket.eventCategory}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ),
      ],
    );
  }

  Widget _buildTime(BuildContext context) {
    return Text(
      // '${ticket.userName}',
      '4.34 PM',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    );
  }

  Widget _buildID(BuildContext context) {
    return Text(
      // '${ticket.userName}',
      '144255624VIP',
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    );
  }


}

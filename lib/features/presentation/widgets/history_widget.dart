import 'package:flutter/material.dart';

class HistoryItemWidget extends StatelessWidget {
  final String time;
  final String ticketNumber;
  final String category;
  final String status;
  final String scannedPerson;
  final String nic;
  final String seatNo;

  const HistoryItemWidget({
    super.key,
    required this.time,
    required this.ticketNumber,
    required this.category,
    required this.status,
    required this.scannedPerson,
    required this.nic,
    required this.seatNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(ticketNumber, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(category, style:  const TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(scannedPerson, style:  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(seatNo, style:  const TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          // Right side - Time and Status
          Column(
            children: [
              Text(time, style: const TextStyle(fontSize: 14, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

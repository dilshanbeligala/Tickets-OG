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
    Key? key,
    required this.time,
    required this.ticketNumber,
    required this.category,
    required this.status,
    required this.scannedPerson,
    required this.nic,
    required this.seatNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the status (green for "Scanned" and red for "Pending")
    Color statusColor = status == 'Failed' ? Colors.red : Colors.green;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Space between history items
      padding: const EdgeInsets.all(12), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the card
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(
          color: Colors.grey.shade300, // Border color
          width: 1, // Border width
        ),
      ),
      child: Row(
        children: [
          // Left side - Ticket info and category
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(ticketNumber, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black)),
                    Text(nic, style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.grey[800])),
                    Text(category, style:  TextStyle(fontSize: 14, color: Colors.grey[800])),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(scannedPerson, style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey[800])),
                    Text(seatNo, style:  TextStyle(fontSize: 14, color: Colors.grey[800])),
                  ],
                ),
              ],
            ),
          ),
          // Right side - Time and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Time in the top right corner
              Text(time, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4), // Space between time and status
              // Status with color
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2), // Background color based on status
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the status container
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor, // Text color based on status
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

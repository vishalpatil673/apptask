import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MedicineItem extends StatelessWidget {
  final String time;
  final String name;
  final String detail;
  final String status;

  MedicineItem({required this.time, required this.name, required this.detail, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 16)),
            Text(detail),
            SizedBox(height: 8),
            Text(status, style: TextStyle(color: _getStatusColor(status))),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Taken':
        return AppColors.successColor;
      case 'Missed':
        return AppColors.dangerColor;
      case 'Snoozed':
        return AppColors.warningColor;
      case 'Left':
        return AppColors.secondaryColor;
      default:
        return Colors.black;
    }
  }
}
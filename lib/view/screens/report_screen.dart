import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReportCard(),
            SizedBox(height: 16),
            _buildDashboardCard(),
            SizedBox(height: 16),
            _buildCheckHistory(),
            SizedBox(height: 16),
            _buildMedicineSection('Morning 08:00 am', [
              _buildMedicineItem('Calpol 500mg Tablet', 'Before Breakfast - Day 01', 'Taken', Icons.check_circle, Colors.green),
              _buildMedicineItem('Calpol 500mg Tablet', 'Before Breakfast - Day 27', 'Missed', Icons.cancel, Colors.red),
            ]),
            SizedBox(height: 16),
            _buildMedicineSection('Afternoon 02:00 pm', [
              _buildMedicineItem('Calpol 500mg Tablet', 'After Food - Day 01', 'Snoozed', Icons.notifications_paused, Colors.orange),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Report", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _reportData('5', 'Total'),
                _reportData('3', 'Taken'),
                _reportData('1', 'Missed'),
                _reportData('1', 'Snoozed'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportData(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDashboardCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Check Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Here you will find everything related\n to active and past medicines.', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            Icon(Icons.pie_chart, color: Colors.blue, size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Check History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(6, (index) {
            List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI'];
            return Column(
              children: [
                Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: index == 0 ? Colors.blue : Colors.grey[300],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: index == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }


  Widget _buildMedicineSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Column(children: items),
      ],
    );
  }

  Widget _buildMedicineItem(String name, String detail, String status, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.medication, color: Colors.blue, size: 32),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(detail, style: TextStyle(color: Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(width: 8),
            Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
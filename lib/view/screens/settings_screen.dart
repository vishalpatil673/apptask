import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/icons.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Notification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Check your medicine notification'),
          SizedBox(height: 16),
          Text('Sound', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Ring, Silent, Vibrate'),
          SizedBox(height: 16),
          Text('Manage Your Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Password, Email ID, Phone Number'),
          SizedBox(height: 16),
          Text('Device', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Connect - Bluetooth, Wi-Fi'),
          SizedBox(height: 16),
          Text('Caretakers: 03', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Diba Luna, Rox Sod., Sunny Tu...'),
          SizedBox(height: 16),
          Text('Doctor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Add Your Doctor or use invite link'),
          SizedBox(height: 16),
          Text('Privacy Policy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Terms of Use', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Rate Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Share', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Log Out', style: TextStyle(color: AppColors.dangerColor)),
          ),
        ],
      ),
    );
  }
}
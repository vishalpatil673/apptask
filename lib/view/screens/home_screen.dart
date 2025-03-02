import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/icons.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedDayIndex = 2;

  final List<String> _weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<String> _dates = ['1', '2', '3', '4', '5', '6', '7'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }
  void _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoConnectionDialog();
    }
    // Listen for changes in connection status
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoConnectionDialog();
      }
    });
  }
  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Your Device is not connected",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/robot.png',
                  height: 120,
                ),
                const SizedBox(height: 15),
                Text(
                  "Connect your device with",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: const Icon(Icons.bluetooth, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: const Icon(Icons.wifi, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi Harry!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            Text('5 Medicines Left', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.card_travel, color: Colors.blue),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();  // Open the drawer when tapped
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildProfileHeader(),
            _buildSettingsSection(),
            _buildDeviceSection(),
            _buildCaretakerSection(),
            _buildDoctorSection(),
            _buildFooterSection(),
            _buildLogoutButton(context),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? _buildHomeContent() : ReportScreen(),
      /*Column(
        children: [
          _buildDateSelector(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSection('Morning 08:00 am', [
                  _buildMedicineCard('Calpol 500mg Tablet', 'Before Breakfast', 'Day 01', Colors.pink.shade100, Icons.check_circle, 'Taken'),
                  _buildMedicineCard('Calpol 500mg Tablet', 'Before Breakfast', 'Day 27', Colors.blue.shade100, Icons.notifications_active, 'Missed'),
                ]),
                _buildSection('Afternoon 02:00 pm', [
                  _buildMedicineCard('Calpol 500mg Tablet', 'After Food', 'Day 01', Colors.purple.shade100, Icons.snooze, 'Snoozed'),
                ]),
                _buildSection('Night 09:00 pm', [
                  _buildMedicineCard('Calpol 500mg Tablet', 'Before Sleep', 'Day 03', Colors.red.shade100, Icons.check, 'Left'),
                ]),
              ],
            ),
          ),
        ],
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        items: [
          BottomNavigationBarItem(icon: Icon(AppIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(AppIcons.report), label: 'Report'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 18,
        onPressed: () {
          Navigator.pushNamed(context, '/addMedicine');
        },
        backgroundColor: Colors.black, // Set background to black
        child: Icon(
          Icons.add, // Use default add icon
          color: Colors.white, // Set icon color to white
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        _buildDateSelector(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildSection('Morning 08:00 am', [
                _buildMedicineCard('Calpol 500mg Tablet', 'Before Breakfast', 'Day 01', Colors.pink.shade100, Icons.check_circle, 'Taken'),
                _buildMedicineCard('Calpol 500mg Tablet', 'Before Breakfast', 'Day 27', Colors.blue.shade100, Icons.notifications_active, 'Missed'),
              ]),
              _buildSection('Afternoon 02:00 pm', [
                _buildMedicineCard('Calpol 500mg Tablet', 'After Food', 'Day 01', Colors.purple.shade100, Icons.snooze, 'Snoozed'),
              ]),
              _buildSection('Night 09:00 pm', [
                _buildMedicineCard('Calpol 500mg Tablet', 'Before Sleep', 'Day 03', Colors.red.shade100, Icons.check, 'Left'),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _weekDays.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedDayIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = index),
            child: Container(
              width: 80,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weekDays[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  Text(_dates[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String time, List<Widget> medicineCards) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(height: 8),
          ...medicineCards,
        ],
      ),
    );
  }

  Widget _buildMedicineCard(String title, String subtitle, String day, Color bgColor, IconData icon, String status) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bgColor,
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('$subtitle  |  $day', style: TextStyle(fontSize: 14, color: Colors.black54)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(height: 4),
            Text(status, style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
      ),
    );
  }
  /// Profile Header Section
  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take Care!', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text('Richa Bose', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  /// Settings Section
  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawerTile(Icons.notifications_outlined, 'Notification', 'Check your medicine notification'),
          _drawerTile(Icons.volume_up_outlined, 'Sound', 'Ring, Silent, Vibrate'),
          _drawerTile(Icons.person_outline, 'Manage Your Account', 'Password, Email ID, Phone Number'),
        ],
      ),
    );
  }

  /// Device Section
  Widget _buildDeviceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Device', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FF), // Light blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _drawerTile(Icons.bluetooth, 'Connect', 'Bluetooth, Wi-Fi'),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _drawerTile(Icons.volume_up_outlined, 'Sound Option', 'Ring, Silent, Vibrate'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Caretaker Section
  Widget _buildCaretakerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Caretakers: 03', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              _caretakerAvatar('assets/images/profile.png', 'Dipa Luna'),
              _caretakerAvatar('assets/images/profile.png', 'Roz Sod.'),
              _caretakerAvatar('assets/images/profile.png', 'Sunny Tu...'),
              _addCaretakerButton(),
            ],
          ),
        ],
      ),
    );
  }

  /// Doctor Section
  Widget _buildDoctorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FF), // Light blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.add_circle_outline, color: Colors.blue, size: 36),
                SizedBox(height: 6),
                Text('Add Your Doctor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: 'Or use ',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'invite link',
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Footer Section (Privacy Policy, Terms, Rate Us, Share)
  Widget _buildFooterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawerTile(Icons.privacy_tip_outlined, 'Privacy Policy', ''),
          _drawerTile(Icons.description_outlined, 'Terms of Use', ''),
          _drawerTile(Icons.star_border_outlined, 'Rate Us', ''),
          _drawerTile(Icons.share_outlined, 'Share', ''),
        ],
      ),
    );
  }

  /// Logout Button
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text('Log Out', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  /// Drawer Tile Widget
  Widget _drawerTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.black54),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey)) : null,
    );
  }

  /// Caretaker Avatar Widget
  Widget _caretakerAvatar(String imagePath, String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          CircleAvatar(radius: 24, backgroundImage: AssetImage(imagePath)),
          SizedBox(height: 4),
          Text(name, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }

  /// Add Caretaker Button
  Widget _addCaretakerButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text('Add', style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}


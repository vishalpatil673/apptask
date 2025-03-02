import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  int selectedCompartment = 1;
  int quantity = 1;
  int totalCount = 1;
  String selectedFrequency = 'Everyday';
  String selectedTimes = 'Three Time';
  bool beforeFood = false, afterFood = false, beforeSleep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Medicines',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Medicine Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),

            // Compartment Selection
            Text('Compartment', style: sectionTitleStyle()),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 14,
                children: List.generate(20, (index) {
                  return ChoiceChip(
                    label: Text('${index + 1}'),
                    selected: selectedCompartment == index + 1,
                    onSelected: (selected) {
                      setState(() {
                        selectedCompartment = index + 1;
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 16),

            // Color Selection
            Text('Colour', style: sectionTitleStyle()),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
               spacing: 14,
                children: List.generate(15, (index) {
                  return CircleAvatar(
                    backgroundColor: Colors.primaries[index],
                    radius: 16,
                  );
                }),
              ),
            ),
            SizedBox(height: 16),

            // Medicine Type Selection
            Text('Type', style: sectionTitleStyle()),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              physics: NeverScrollableScrollPhysics(),
              children: [
                medicineTypeIcon(Icons.local_pharmacy, "Tablet"),
                medicineTypeIcon(Icons.medical_services, "Capsule"),
                medicineTypeIcon(Icons.blender, "Cream"),
                medicineTypeIcon(Icons.opacity, "Liquid"),
              ],
            ),
            SizedBox(height: 16),

            // Quantity Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity', style: sectionTitleStyle()),
                Row(
                  children: [
                    quantityButton(Icons.remove, () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('$quantity Pill', style: TextStyle(fontSize: 16)),
                    ),
                    quantityButton(Icons.add, () {
                      setState(() {
                        quantity++;
                      });
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Total Count
            Text('Total Count', style: sectionTitleStyle()),
            Slider(
              value: totalCount.toDouble(),
              min: 1,
              max: 100,
              divisions: 100,
              label: '$totalCount',
              onChanged: (value) {
                setState(() {
                  totalCount = value.toInt();
                });
              },
            ),
            SizedBox(height: 16),

            // Set Date
            Text('Set Date', style: sectionTitleStyle()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dateButton("Today"),
                dateButton("End Date"),
              ],
            ),
            SizedBox(height: 16),

            // Frequency of Days
            Text('Frequency of Days', style: sectionTitleStyle()),
            DropdownButton(
              isExpanded: true,
              value: selectedFrequency,
              items: ['Everyday', 'Alternate Days', 'Weekly']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // How many times a day
            Text('How many times a Day', style: sectionTitleStyle()),
            DropdownButton(
              isExpanded: true,
              value: selectedTimes,
              items: ['One Time', 'Two Time', 'Three Time']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTimes = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // Time selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                foodChoiceChip('Before Food', beforeFood, (selected) {
                  setState(() {
                    beforeFood = selected;
                  });
                }),
                foodChoiceChip('After Food', afterFood, (selected) {
                  setState(() {
                    afterFood = selected;
                  });
                }),
                foodChoiceChip('Before Sleep', beforeSleep, (selected) {
                  setState(() {
                    beforeSleep = selected;
                  });
                }),
              ],
            ),
            SizedBox(height: 24),

            // Add Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  TextStyle sectionTitleStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  Widget medicineTypeIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.pinkAccent),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.blue),
      onPressed: onPressed,
    );
  }

  Widget dateButton(String label) {
    return Text(label, style: TextStyle(fontSize: 16, color: Colors.blue));
  }

  Widget foodChoiceChip(String label, bool selected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.blue.shade100,
    );
  }
}

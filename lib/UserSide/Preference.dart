import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_ease/UserSide/preferenceController.dart';
// import 'package:travel_ease/UserSide/preferences_controller.dart';

class Preference extends StatefulWidget {
  const Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  final TextEditingController costController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final PreferencesController preferencesController =
      Get.put(PreferencesController());

  @override
  void initState() {
    super.initState();
    // Load saved values if they exist
    costController.text = preferencesController.storedCost.value.toString();
    locationController.text = preferencesController.storedLocation.value;
  }

  void savePreferences() {
    final int? cost = int.tryParse(costController.text);
    final String location = locationController.text;

    if (cost != null && location.isNotEmpty) {
      preferencesController.clearPreferences();
      preferencesController.saveCostPreference(cost);
      preferencesController.saveLocationPreference(location);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved!')),
      );

      // Update UI to reflect changes
      setState(() {
        costController.text = cost.toString();
        locationController.text = location;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color(0xFFC5DDFF),
          leading: IconButton(
            icon: Image.asset(
              "images/back.png",
              height: 70,
              width: 70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'preference',
            style: TextStyle(
                color: Color(0xff323643), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cost Preference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Text(
                preferencesController.storedCost.value != 0
                    ? 'Saved Cost: ${preferencesController.storedCost.value}'
                    : 'No Cost Preference Saved',
                style: TextStyle(
                  color: preferencesController.storedCost.value != 0
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text(
              'Location Preference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Text(
                preferencesController.storedLocation.value.isNotEmpty
                    ? 'Saved Location: ${preferencesController.storedLocation.value}'
                    : 'No Location Preference Saved',
                style: TextStyle(
                  color: preferencesController.storedLocation.value.isNotEmpty
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: savePreferences,
                child: const Text('Save Preferences'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

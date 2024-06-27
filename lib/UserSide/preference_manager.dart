import 'package:get_storage/get_storage.dart';

class PreferencesManager {
  final GetStorage _storage = GetStorage();

  // Method to save cost preference
  void saveCostPreference(int cost) {
    _storage.write('cost', cost);
  }

  // Method to get cost preference
  int? getCostPreference() {
    return _storage.read('cost');
  }

  // Method to save location preference
  void saveLocationPreference(String location) {
    _storage.write('location', location);
  }

  // Method to get location preference
  String? getLocationPreference() {
    return _storage.read('location');
  }

  // Method to clear cost preference
  void clearCostPreference() {
    _storage.remove('cost');
  }

  // Method to clear location preference
  void clearLocationPreference() {
    _storage.remove('location');
  }
}

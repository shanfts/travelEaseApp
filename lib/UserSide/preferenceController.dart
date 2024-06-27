import 'package:get/get.dart';
import 'package:travel_ease/UserSide/preference_manager.dart';

class PreferencesController extends GetxController {
  final PreferencesManager preferencesManager = PreferencesManager();

  var storedCost = 0.obs;
  var storedLocation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPreferences();
  }

  void fetchPreferences() {
    storedCost.value = preferencesManager.getCostPreference() ?? 0;
    storedLocation.value = preferencesManager.getLocationPreference() ?? '';
  }

  void saveCostPreference(int cost) {
    preferencesManager.saveCostPreference(cost);
    storedCost.value = cost;
  }

  void saveLocationPreference(String location) {
    preferencesManager.saveLocationPreference(location);
    storedLocation.value = location;
  }

  void clearPreferences() {
    preferencesManager.clearCostPreference();
    preferencesManager.clearLocationPreference();
    storedCost.value = 0;
    storedLocation.value = '';
  }
}

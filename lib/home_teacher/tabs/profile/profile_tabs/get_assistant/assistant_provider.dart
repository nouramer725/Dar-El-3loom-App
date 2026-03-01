import 'package:flutter/cupertino.dart';

import '../../../../../BackendSetup Data/Api/api_service.dart';
import 'assistant_model.dart';

class AssistantProvider extends ChangeNotifier {
  final ApiService apiService;

  AssistantProvider(this.apiService);

  bool isLoading = false;
  List<AssistantModel> assistants = [];

  Future<void> fetchAssistants() async {
    print("🔥 fetchAssistants CALLED");

    isLoading = true;
    notifyListeners();

    try {
      assistants = await apiService.getAssistants();
      print("✅ assistants length = ${assistants.length}");
    } catch (e) {
      print("❌ ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
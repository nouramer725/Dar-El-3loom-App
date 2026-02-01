import 'shared_preferences_theme.dart';
import '../utils/app_routes.dart';

class AppFlow {
  static const firstTime = "first";
  static const details = "details";
  static const completed = "completed";

  static String getInitialRoute() {
    final step = SharedPreferencesTheme.getUserStep();

    final isLoggedOut = SharedPreferencesTheme.getUserStep() == "logout";

    if (isLoggedOut) {
      return AppRoutes.loginScreen;
    }

    switch (step) {
      case details:
        return AppRoutes.detailsScreen;
      case completed:
        return AppRoutes.homeScreenName;
      default:
        return AppRoutes.firstTimeLoginScreenName;
    }
  }

  static Future<void> goToDetails() async {
    await SharedPreferencesTheme.setUserStep(details);
  }

  static Future<void> goToCompleted() async {
    await SharedPreferencesTheme.setUserStep(completed);
  }

  static Future<void> logout() async {
    await SharedPreferencesTheme.setUserStep("logout");
  }
}

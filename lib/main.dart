import 'package:dar_el_3loom/provider/app_flow.dart';
import 'package:dar_el_3loom/provider/app_theme_provider.dart';
import 'package:dar_el_3loom/provider/shared_preferences_theme.dart';
import 'package:dar_el_3loom/provider/student_login_provider.dart';
import 'package:dar_el_3loom/utils/app_routes.dart';
import 'package:dar_el_3loom/utils/app_theme.dart';
import 'package:dar_el_3loom/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Login/Details Screen/details_screen.dart';
import 'Login/First Login Screen/first_time_login_screen.dart';
import 'Login/login/login_screen.dart';
import 'home/containers_contents/Balance/balance_screen.dart';
import 'home/containers_contents/Certificates/taqarer_screen.dart';
import 'home/containers_contents/Mozakrat/container3_press.dart';
import 'home/containers_contents/Performance/performance_screen.dart';
import 'home/containers_contents/Table Time/table_time_screen.dart';
import 'home/home_screen.dart';
import 'home/tabs/profile/profile_tabs/password_edit.dart';
import 'home/tabs/profile/profile_tabs/profile_picture_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await SharedPreferencesTheme.init();

  final studentProvider = StudentLoginProvider();
  await studentProvider.loadStudent();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => studentProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,

      initialRoute: AppFlow.getInitialRoute(context),

      builder: (context, child) {
        SizeConfig.init(context);
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },

      routes: {
        AppRoutes.firstTimeLoginScreenName: (_) => FirstTimeLoginScreen(),
        AppRoutes.detailsScreen: (_) => DetailsScreen(),
        AppRoutes.loginScreen: (_) => LoginScreen(),
        AppRoutes.homeScreenName: (_) => HomeScreen(),
        AppRoutes.container1Press: (_) => PerformanceScreen(),
        AppRoutes.container2Press: (_) => TableTimeScreen(),
        AppRoutes.container3Press: (_) => MozakratScreen(),
        AppRoutes.container4Press: (_) => BalanceScreen(),
        AppRoutes.container5Press: (_) => TaqreerScreen(),
        AppRoutes.passwordEdit: (_) => PasswordEdit(),
        AppRoutes.profilePictureEdit: (_) => ProfilePictureWidget(),
      },
    );
  }
}

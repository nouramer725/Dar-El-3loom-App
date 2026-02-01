import 'package:dar_el_3loom/provider/app_flow.dart';
import 'package:dar_el_3loom/provider/app_theme_provider.dart';
import 'package:dar_el_3loom/provider/shared_preferences_theme.dart';
import 'package:dar_el_3loom/utils/app_routes.dart';
import 'package:dar_el_3loom/utils/app_theme.dart';
import 'package:dar_el_3loom/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Login/Details Screen/details_screen.dart';
import 'Login/First Login Screen/first_time_login_screen.dart';
import 'Login/login/login_screen.dart';
import 'home/containers_contents/Container1/container1_press.dart';
import 'home/containers_contents/Container2/container2_press.dart';
import 'home/containers_contents/Container3/container3_press.dart';
import 'home/containers_contents/Container4/container4_press.dart';
import 'home/containers_contents/Container5/container5_press.dart';
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
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppThemeProvider())],
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
      initialRoute: AppFlow.getInitialRoute(),
      builder: (context, child) {
        SizeConfig.init(context);
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      routes: {
        AppRoutes.firstTimeLoginScreenName: (context) => FirstTimeLoginScreen(),
        AppRoutes.detailsScreen: (context) => DetailsScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.homeScreenName: (context) => HomeScreen(),
        AppRoutes.container1Press: (context) => Container1Press(),
        AppRoutes.container2Press: (context) => Container2Press(),
        AppRoutes.container3Press: (context) => Container3Press(),
        AppRoutes.container4Press: (context) => Container4Press(),
        AppRoutes.container5Press: (context) => Container5press(),
        AppRoutes.passwordEdit: (context) => PasswordEdit(),
        AppRoutes.profilePictureEdit: (context) => ProfilePictureWidget(),
      },
    );
  }
}

/// req:
/// 1)  enter code of student and parent number (for the first time)
/// 2) check data of this student :
///   الاسم و الصف و رقم الطالب و رقم ولي الامر و الرقم القومي و الباسورد وتاكيد الباسورد و صورة شهاده الميلاد وصورة الشخصية
///

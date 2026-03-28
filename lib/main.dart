import 'package:dar_el_3loom/auth/Details%20Screen/details_assistant_screen.dart';
import 'package:dar_el_3loom/auth/Details%20Screen/details_parent_screen.dart';
import 'package:dar_el_3loom/auth/Details%20Screen/details_teacher_screen.dart';
import 'package:dar_el_3loom/home_assistant/containers/groups/group_performance.dart';
import 'package:dar_el_3loom/home_assistant/containers/student_performance/student_performance.dart';
import 'package:dar_el_3loom/home_assistant/containers/student_performance/student_performance_table_widget.dart';
import 'package:dar_el_3loom/home_assistant/containers/taqarer_student_assistant/taqarer_assistant.dart';
import 'package:dar_el_3loom/home_assistant/home_assistant_screen.dart';
import 'package:dar_el_3loom/home_assistant/tabs/profile/profile_tabs/password_assistant_edit.dart';
import 'package:dar_el_3loom/home_assistant/tabs/profile/profile_tabs/profile_picture_assistant_widget.dart';
import 'package:dar_el_3loom/home_parent/tabs/profile/profile_tabs/password_parent_edit.dart';
import 'package:dar_el_3loom/home_parent/tabs/profile/profile_tabs/profile_picture_parent_widget.dart';
import 'package:dar_el_3loom/home_teacher/containers/assistantAddition/add_new_assistant_screen.dart';
import 'package:dar_el_3loom/home_teacher/containers/groups/groups.dart';
import 'package:dar_el_3loom/home_teacher/containers/taqarer_student/taqarer.dart';
import 'package:dar_el_3loom/home_teacher/home_teacher_screen.dart';
import 'package:dar_el_3loom/home_teacher/tabs/profile/profile_tabs/get_assistant/get_assistant_screen.dart';
import 'package:dar_el_3loom/home_teacher/tabs/profile/profile_tabs/password_teacher_edit.dart';
import 'package:dar_el_3loom/home_teacher/tabs/profile/profile_tabs/profile_picture_teacher_widget.dart';
import 'package:dar_el_3loom/provider/app_flow.dart';
import 'package:dar_el_3loom/provider/app_theme_provider.dart';
import 'package:dar_el_3loom/provider/assistant_login_provider.dart';
import 'package:dar_el_3loom/provider/parent_login_provider.dart';
import 'package:dar_el_3loom/provider/shared_preferences_theme.dart';
import 'package:dar_el_3loom/provider/student_login_provider.dart';
import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:dar_el_3loom/utils/app_routes.dart';
import 'package:dar_el_3loom/utils/app_theme.dart';
import 'package:dar_el_3loom/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'backend_setup/Api/api_service.dart';
import 'auth/Details Screen/details_screen.dart';
import 'auth/First Login Screen/first_time_login_screen.dart';
import 'auth/login/login_screen.dart';
import 'home/containers_contents/Balance/balance_screen.dart';
import 'home/containers_contents/Certificates/taqarer_screen.dart';
import 'home/containers_contents/Mozakrat/container3_press.dart';
import 'home/containers_contents/Performance/performance_screen.dart';
import 'home/containers_contents/Table Time/table_time_screen.dart';
import 'home/home_screen.dart';
import 'home/tabs/profile/profile_tabs/password_edit.dart';
import 'home/tabs/profile/profile_tabs/profile_picture_widget.dart';
import 'home_parent/home_parent_screen.dart';
import 'home_teacher/tabs/profile/profile_tabs/get_assistant/assistant_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cacheBox');

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

  final parentProvider = ParentLoginProvider();
  await parentProvider.loadParent();

  final teacherProvider = TeacherLoginProvider();
  await teacherProvider.loadTeacher();

  final assistantProvider = AssistantLoginProvider();
  await assistantProvider.loadAssistant();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => studentProvider),
        ChangeNotifierProvider(create: (_) => parentProvider),
        ChangeNotifierProvider(create: (_) => teacherProvider),
        ChangeNotifierProvider(create: (_) => assistantProvider),
        ChangeNotifierProvider(
          create: (_) => AssistantProvider(ApiService())..fetchAssistants(),
        ),
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
      darkTheme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppFlow.getInitialRoute(context),
      builder: (context, child) {
        SizeConfig.init(context);
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      navigatorKey: navigatorKey,
      routes: {
        AppRoutes.firstTimeLoginScreenName: (_) => FirstTimeLoginScreen(),
        AppRoutes.detailsScreen: (_) => DetailsScreen(),
        AppRoutes.detailsParentScreen: (_) => DetailsParentScreen(),
        AppRoutes.detailsTeacherScreen: (_) => DetailsTeacherScreen(),
        AppRoutes.detailsAssistantScreen: (_) => DetailsAssistantScreen(),
        AppRoutes.loginScreen: (_) => LoginScreen(),
        AppRoutes.homeScreenName: (_) => HomeScreen(),
        AppRoutes.homeParentScreenName: (_) => HomeParentScreen(),
        AppRoutes.homeTeacherScreenName: (_) => HomeTeacherScreen(),
        AppRoutes.addAssistantTeacherScreen: (_) => AddNewAssistantScreen(),
        AppRoutes.container1Press: (_) => PerformanceScreen(),
        AppRoutes.container2Press: (_) => TableTimeScreen(),
        AppRoutes.container3Press: (_) => MozakratScreen(),
        AppRoutes.container4Press: (_) => BalanceScreen(),
        AppRoutes.container5Press: (_) => TaqreerScreen(),
        AppRoutes.taqrerStudentPress: (_) => TaqarerTeacherScreen(),
        AppRoutes.groupsPress: (_) => GroupsScreen(),
        AppRoutes.passwordEdit: (_) => PasswordEdit(),
        AppRoutes.profilePictureEdit: (_) => ProfilePictureWidget(),
        AppRoutes.passwordParentEdit: (_) => PasswordParentEdit(),
        AppRoutes.profilePictureParentEdit: (_) => ProfilePictureParentWidget(),
        AppRoutes.passwordTeacherEdit: (_) => PasswordTeacherEdit(),
        AppRoutes.profilePictureTeacherEdit: (_) =>
            ProfilePictureTeacherWidget(),
        AppRoutes.passwordAssistantEdit: (_) => PasswordAssistantEdit(),
        AppRoutes.studentPerformanceAssistant: (_) => StudentPerformance(),
        AppRoutes.studentPerformanceAssistantDtaScreen: (_) =>
            StudentPerformanceWidget(studentData: {}),
        AppRoutes.profilePictureAssistantWidget: (_) =>
            ProfilePictureAssistantWidget(),
        AppRoutes.homeAssistantScreenName: (_) => HomeAssistantScreen(),
        AppRoutes.addAssistantScreen: (_) => GetAssistantScreen(),
        AppRoutes.taqarerAssistant: (_) => TaqarerAssistant(),
        AppRoutes.groupPerformance: (_) => GroupPerformanceScreen(),
      },
    );
  }
}

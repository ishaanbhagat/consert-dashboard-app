import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:grid_app/views/dashboard_view.dart';
import 'package:provider/provider.dart';

import 'dependencies/injection_container.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer.setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientController()),
      ],
      child: ScreenUtilInit(
          designSize: Size(360, 690),
          builder: (_, child) {
            return MaterialApp(
              title: 'Patient App',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              scaffoldMessengerKey: scaffoldMessengerKey,
              locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    titleTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black)
                    
                    ),
                    
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff22d360),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                )),
                inputDecorationTheme: InputDecorationTheme(
                  // contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              home: DashboardView(),
            );
          }),
    );
  }
}

// ffffff, 6ce797, 81cef7, e2a2ff, 22d360, 0d8ed3, c233ff
// 2024-12-04 16:05:34
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Auth/presentation/screens/auth_screen.dart';
import 'package:up_todo/core/cache_service/cache_service.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheService.initHive();

  initGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            home: const AuthScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
            ),

          );
        });
  }
}

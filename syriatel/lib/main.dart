import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syriatel/bindings/home_binding.dart';
import 'package:syriatel/bindings/login_binding.dart';
import 'package:syriatel/services/storage_service.dart';
import 'package:syriatel/theme/size_config.dart';
import 'package:syriatel/view/login.dart';
import 'package:syriatel/view/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ تهيئة SharedPreferences
  await StorageService.init();

  // ✅ تحقق من التوكن
  final isLoggedIn = StorageService.isTokenValid();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red
          , colorScheme: ColorScheme.fromSwatch().copyWith( primary: Colors.red, secondary: Colors.redAccent, ),),

      debugShowCheckedModeBanner: false,
      title: "Syriatel",

      initialBinding: isLoggedIn ? HomeBinding() : LoginBinding(),


      initialRoute: isLoggedIn ? '/main' : '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => Login(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => MainScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}

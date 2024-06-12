import 'package:flutter/material.dart';
import 'package:notes_app/pages/login_page.dart';
import 'package:notes_app/utils/user_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //apakah inisialisasi sdh berhasil sblm aplikasi dirunning, kalo belum dia bakal error
  await UserSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

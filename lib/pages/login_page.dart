import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/utils/user_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController pinController;

  //buat ngecek apakah pin sudah pernah tersimpan di shared pref atau belum
  bool isPinExist = false;

  String? _pin;

  @override
  void initState() {
    nameController = TextEditingController();
    pinController = TextEditingController();
    String? pin = UserSharedPreferences.getPin();
    if(pin != null) {
      setState(() {
        isPinExist = true;
        _pin = pin;
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // fungsi: tatkala aplikasi ditutup, dia gabakal ngehambat performa
    super.dispose();
    nameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "🍁 SimplyNote 🍁",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Nickname",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 42,
              ),
              child: TextField(
                controller: nameController,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Text(
              "PIN",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 42,
              ),
              child: TextField(
                controller: pinController,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.brown)),
                onPressed: () async {
                  await UserSharedPreferences.setName(
                    // buat ngisisdata nama sama pin ke shared prefernces lewat controller
                    name: nameController.text, 
                    pin: pinController.text,
                  );
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const HomePage();
                  }));
                },
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}

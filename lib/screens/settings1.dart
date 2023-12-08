import 'package:flutter/material.dart';
import 'package:projectopia/screens/ai_analize.dart';
import 'package:projectopia/screens/lobby_screen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings2 extends StatefulWidget {
  const Settings2({super.key});

  @override
  State<Settings2> createState() => _Settings2State();
}

class _Settings2State extends State<Settings2> {
  bool initval = false;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    void navMenuTapped(int index) {
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Lobby()));
      } else if (index == 1) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Aianalize()));
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Проекты'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          onTap: navMenuTapped,
          selectedItemColor: const Color.fromARGB(255, 93, 176, 239),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: "Проекты",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "AI Анализ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Настройки",
            ),
          ],
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
                margin: const EdgeInsetsDirectional.all(16.0),
                title: const Text(
                  'Настройки Аккаунта',
                ),
                tiles: [
                  SettingsTile.navigation(title: Text("Логин: ${user?.email}")),
                  SettingsTile(
                    title: const Text("Сменить пароль?"),
                    leading: const Icon(Icons.password),
                    onPressed: (context) {
                      Navigator.pushNamed(context, "/reset_password");
                    },
                  ),
                  SettingsTile(
                    title: const Text("Выйти с аккаунта?"),
                    leading: const Icon(Icons.logout),
                    onPressed: (context) {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

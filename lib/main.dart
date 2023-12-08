import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectopia/config.dart';
import 'package:projectopia/screens/lobby_screen.dart';
import 'package:projectopia/screens/sign_up_screen.dart';
import 'package:projectopia/screens/login_screen.dart';
import 'package:projectopia/screens/reset_password.dart';
import 'package:projectopia/screens/verify_email_screen.dart';
import 'package:projectopia/services/firebase_stream.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apikey,
          appId: appID,
          messagingSenderId: '',
          projectId: projectID));

  runApp(Provider<Datastorage>(
      create: (context) => Datastorage(),
      child: MainWidget(
        initialization: Firebase.app(),
      )));
}

class Datastorage with ChangeNotifier {
  String _storedValue = '';

  String get storedValue => _storedValue;

  void updateValue(String newValue) {
    _storedValue = newValue;
    notifyListeners();
  }
}

class MainWidget extends StatelessWidget {
  final FirebaseApp initialization;
  const MainWidget({super.key, required this.initialization});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(initialization),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
                'Ошибка инициализации Firebase, проверьте соединение с интернетом'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Projectopia',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder()
              }),
              primaryColor: Colors.black,
              cardTheme: const CardTheme(
                color: Color.fromARGB(221, 217, 217, 217),
              ),
              hintColor: Colors.black,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 166, 202, 230),
                  foregroundColor: Colors.black),
              colorScheme: const ColorScheme.highContrastLight(),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const FirebaseStream(),
              '/home': (context) => const Lobby(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/reset_password': (context) => const ResetPasswordScreen(),
              '/verify_email': (context) => const VerifyEmailScreen(),
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

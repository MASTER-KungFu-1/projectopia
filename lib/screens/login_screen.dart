import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectopia/base_info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool savePassword = false;

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login(savePassword) async {
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();
    final Map? args = ModalRoute.of(context)?.settings.arguments as Map?;
    final bool isVerified = args?['isVerified'] ?? true;
    if (!isValid) return;
    if (!isVerified) {
      await Navigator.pushNamed(context, '/verify_email');
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextInputController.text.trim(),
          password: passwordTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Неправильный email или пароль!'),
          ),
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка входа: ${e.code}'),
          ),
        );
        return;
      }
    }
    if (savePassword) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isAuthorized', 'yes');
    }
    navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Войти'),
        ),
        body: Center(
          child: ListView(shrinkWrap: true, children: [
            const Text(
              'Вход',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            SingleChildScrollView(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(40.0, 15.0, 40.0, 15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: emailTextInputController,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Введите правильный Email'
                              : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Введите Email',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      autocorrect: false,
                      controller: passwordTextInputController,
                      obscureText: isHiddenPassword,
                      validator: (value) => value != null && value.length < 6
                          ? 'Минимум 6 символов'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Введите пароль',
                        suffix: InkWell(
                          onTap: togglePasswordView,
                          child: Icon(
                            isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          splashRadius: Checkbox.width,
                          checkColor: Colors.black,
                          activeColor: const Color.fromARGB(255, 166, 202, 230),
                          value: savePassword,
                          onChanged: (bool? newValue) {
                            setState(() {
                              savePassword = !savePassword;
                            });
                          },
                        ),
                        const Text(
                          'Запомнить Пароль?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await login(savePassword);
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 166, 202, 230)),
                        textStyle: MaterialStatePropertyAll(TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                        )),
                      ),
                      child: const Text(
                        'Войти',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/signup'),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/reset_password'),
                      child: const Text(
                        'Сбросить пароль',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

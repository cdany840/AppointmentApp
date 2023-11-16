import 'package:appointment_app/presentation/widgets/login/login_form.dart';
import 'package:appointment_app/presentation/widgets/login/login_icons_buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 64, 112, 112),
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 191, 211, 244)
            ),
            child: LoginForm(
              emailController: userCont,
              passController: passCont,
            ),
          ),          
          const LoginIconsButtons(
            color: Color.fromARGB(255, 51, 51, 51),
          ),
        ],
      ),
    );
  }
}
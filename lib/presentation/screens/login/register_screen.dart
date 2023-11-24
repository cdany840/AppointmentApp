import 'package:appointment_app/presentation/widgets/login/register_form.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 64, 112, 112),
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body:   Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LottieBuilder.asset(
              "assets/animations/a.json",
              //height: 340,
            ),
          ),
         Align(
            alignment: Alignment.topCenter,
            child: LottieBuilder.asset(
              "assets/animations/xmaslogin.json",
              height: 200,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal,
                ),
                child: RegisterForm(
                  emailController: userCont,
                  passController: passCont,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
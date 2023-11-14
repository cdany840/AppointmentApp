import 'package:appointment_app/presentation/screens/onboarding/card_data.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final data = [
    CardData(
      title: "Sección 1",
      subtitle: "Formar Ingenieros en el análisis, síntesis y realización de investigación en semiconductores.",
      image: const AssetImage("assets/images/Semiconductors.png"),
      backgroundColor: const Color.fromARGB(255, 7, 153, 182),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/animation.json"),
    ),
    CardData(
      title: "Sección 2",
      subtitle: "El egresado tiene conocimientos para desarrollarse en la tecnología con mayor dinamismo.",
      image: const AssetImage("assets/images/Electronic.png"),
      backgroundColor: const Color.fromARGB(255, 74, 110, 176),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/animation.json"),
    ),
    CardData(
      title: "Sección 3",
      subtitle: "El egresado es un profesional que posee una sólida fundamentación en las ciencias básicas.",
      image: const AssetImage("assets/images/Industrial.png"),
      backgroundColor: const Color.fromARGB(255, 17, 76, 95),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/animation.json"),
    ),
    CardData(
      title: "Sección 4",
      subtitle: "El egresado en Sistemas, tiene conocimientos de alto nivel tecnológico y científico.",
      image: const AssetImage("assets/images/Systems.png"),
      backgroundColor: const Color.fromARGB(255, 156, 210, 211),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/animation.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardCourse(data: data[index]);
        },
      ),
    );
  }
  
}
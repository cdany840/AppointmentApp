import 'package:appointment_app/presentation/screens/onboarding/card_data.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final data = [
    CardData(
      title: "Bienvenido a CitaElite",
      subtitle: "Gestiona y haz crecer tu negocio con facilidad. Desde la gestión de servicios hasta la organización de citas, estamos aquí para simplificar tu día a día.",
      image: const AssetImage("assets/images/real.png"),
      backgroundColor: const Color.fromARGB(255, 7, 153, 182),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/bmax.json"),
    ),
    CardData(
      title: "Destaca tus servicios únicos",
      subtitle: "Personaliza y promociona cada servicio que ofreces. Desde cortes de cabello hasta coaching empresarial, haz que tu negocio destaque.",
      image: const AssetImage("assets/images/real.png"),
      backgroundColor: const Color.fromARGB(255, 74, 110, 176),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/destacar.json"),
    ),
    CardData(
      title: "Organiza tu agenda, satisface a tus clientes",
      subtitle: "Mantén un seguimiento claro de tus citas, pendientes y completadas. Clientes satisfechos son clientes recurrentes.",
      image: const AssetImage("assets/images/real.png"),
      backgroundColor: const Color.fromARGB(255, 17, 76, 95),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/f.json"),
    ),
    CardData(
      title: "Tu negocio en tus manos",
      subtitle: "Accede a tu información de negocio en cualquier momento y lugar. Tu oficina está donde tú estés.",
      image: const AssetImage("assets/images/real.png"),
      backgroundColor: Color.fromARGB(255, 46, 75, 132),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animations/empresario.json"),
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
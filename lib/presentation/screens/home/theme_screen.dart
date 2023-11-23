import 'package:appointment_app/presentation/providers/provider_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

















class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});
  final List<Color> colores = [
    const Color( 0xFF49149F ),
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    // ? Juan's Colors
    const Color.fromARGB(255, 51, 51, 51),
    const Color.fromARGB(255, 245, 245, 245),
    const Color.fromARGB(255, 64, 112, 112),
    const Color.fromARGB(255, 64, 103, 76),
    const Color.fromARGB(255, 191, 211, 244),
  ];

  @override
  Widget build(BuildContext context) {
    final changeTheme = context.watch<ProviderTheme>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Colors'),
      ),
      body: ListView.builder(
        itemCount: colores.length,
        itemBuilder: (context, index) {
          Color color = colores[index];
          return ListTile(
            title: Text('Color ${index + 1}'),
            leading: Container(
              width: 30,
              height: 30,
              color: color,
            ),
            onTap: () {              
              changeTheme.setColorValue(index);
            },
          );
        },
      ),
    );
  }
}
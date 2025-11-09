import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WaterClock')),
      body: const Center(
        child: Text('Bem-vindo ao WaterClock!', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

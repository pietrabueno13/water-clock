import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6F5FF), Color(0xFFDFF3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlutterLogo(size: 120),

              const SizedBox(height: 16),

              const Text(
                'WaterClock',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2B3C),
                ),
              ),

              const SizedBox(height: 48),

              // Botão ENTRAR
              RoundedButton(
                text: 'Entrar',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),

              const SizedBox(height: 12),

              // Botão CRIAR CONTA
              RoundedButton(
                text: 'Criar conta',
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),

              const SizedBox(height: 12),

              // Botão convidado
              SizedBox(
                width: 240,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Colors.black26),
                    ),
                    elevation: 1,
                  ),
                  child: const Text(
                    'Entrar como convidado',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 73, 97), // Azul meio claro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/logo.png'), // Adicione a sua logo no assets
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nome do aplicativo
            const Text(
              "Cadastros\n Academia Bem Estar",
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 50),

            // Botão estilizado
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/lista_alunos'); // Navega para a tela de cadastro
                },
                icon: const Icon(Icons.person_add, size: 24),
                label: const Text(
                  "Cadastro de Alunos",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Cor de fundo branca
                  foregroundColor: Colors.blueAccent, // Cor do texto e ícone
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Borda arredondada
                  ),
                  elevation: 5, // Efeito de sombra
                )),

            const SizedBox(height: 50),

            // Rodapé com informações de contato
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ryan sistemas e soluções\n(82)98219-9052\nryannestacio@icloud.com",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6), // Texto meio fosco
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 1),
                //  Text(
                //    "(82)98219-9052",
                //     style: TextStyle(
                //      fontSize: 12,
                //      color: Colors.white.withOpacity(0.6),
                //    ),
                //    textAlign: TextAlign.center,
                //  ),
                //  const SizedBox(height: 5),
                //Text(
                //    "ryannestacio@icloud.com",
                //    style: TextStyle(
                //      fontSize: 12,
                //      color: Colors.white.withOpacity(0.6),
                //    ),
                //    textAlign: TextAlign.center,
                //  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './screens/lista_alunos.dart'; // Tela que você vai criar para listar alunos
import './providers/aluno_provider.dart'; // Provider de alunos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlunoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove a faixa de debug
        title: 'Academia Bem Estar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(), // A tela inicial estilizada
        routes: {
          '/lista_alunos': (context) =>
              const ListaAlunos(), // Adicione outras rotas conforme necessário
        },
      ),
    );
  }
}

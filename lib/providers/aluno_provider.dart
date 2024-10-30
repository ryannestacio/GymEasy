import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../database/database_helper.dart';

class AlunoProvider with ChangeNotifier {
  List<Aluno> _alunos = [];

  List<Aluno> get alunos => _alunos;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Carrega os alunos do banco de dados
  Future<void> carregarAlunos() async {
    _alunos = await _dbHelper.getAlunos();
    notifyListeners();
  }

  // Adiciona um aluno
  Future<void> adicionarAluno(Aluno aluno) async {
    await _dbHelper.inserirAluno(aluno);
    await carregarAlunos(); // Recarrega a lista após adicionar
  }

  // Atualiza um aluno
  Future<void> atualizarAluno(Aluno aluno) async {
    await _dbHelper.atualizarAluno(aluno);
    await carregarAlunos(); // Recarrega a lista após atualizar
  }

  // Remove um aluno
  Future<void> removerAluno(int id) async {
    await _dbHelper.deletarAluno(id);
    await carregarAlunos(); // Recarrega a lista após remover
  }
}

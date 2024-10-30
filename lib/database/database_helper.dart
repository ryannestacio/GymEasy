import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/aluno.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  // Nome do banco de dados
  final String _dbName = 'academia.db';
  final String _tableName = 'alunos';

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          diaPagamento INTEGER NOT NULL, 
          endereco TEXT NOT NULL,
          valorMensalidade REAL NOT NULL
        )''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
              'ALTER TABLE $_tableName ADD COLUMN diaPagamento INTEGER');
        }
      },
    );
  }

  // Método para inserir um aluno
  Future<int> inserirAluno(Aluno aluno) async {
    final db = await database;
    return await db.insert(_tableName, {
      'nome': aluno.nome,
      'diaPagamento': aluno.diaPagamento,
      'endereco': aluno.endereco,
      'valorMensalidade': aluno.valorMensalidade,
    });
  }

  // Método para obter todos os alunos
  Future<List<Aluno>> getAlunos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Aluno(
        id: maps[i]['id'], // Recupera o id
        nome: maps[i]['nome'],
        diaPagamento: maps[i]['diaPagamento'], // Alterado para int
        endereco: maps[i]['endereco'],
        valorMensalidade: maps[i]['valorMensalidade'],
      );
    });
  }

  // Método para atualizar um aluno
  Future<void> atualizarAluno(Aluno aluno) async {
    final db = await database;
    await db.update(
      _tableName,
      {
        'nome': aluno.nome,
        'diaPagamento': aluno.diaPagamento, // Alterado para int
        'endereco': aluno.endereco,
        'valorMensalidade': aluno.valorMensalidade,
      },
      where: 'id = ?',
      whereArgs: [aluno.id],
    );
  }

  // Método para deletar um aluno
  Future<void> deletarAluno(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método para fechar o banco de dados
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}

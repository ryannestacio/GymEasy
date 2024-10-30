import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aluno.dart';
import '../providers/aluno_provider.dart';

class CadastroAluno extends StatefulWidget {
  final Aluno? aluno; // Recebe o aluno para edição, se houver

  const CadastroAluno({super.key, this.aluno});

  @override
  _CadastroAlunoState createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _valorMensalidadeController = TextEditingController();
  int? _diaPagamento;

  @override
  void initState() {
    super.initState();

    // Se o aluno estiver sendo editado, preencher os campos
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
      _enderecoController.text = widget.aluno!.endereco;
      _valorMensalidadeController.text =
          widget.aluno!.valorMensalidade.toStringAsFixed(2);
      _diaPagamento = widget.aluno!.diaPagamento; // Alterado para int
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    _valorMensalidadeController.dispose();
    super.dispose();
  }

  void _salvarAluno() async {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final endereco = _enderecoController.text;
      final valorMensalidade =
          double.tryParse(_valorMensalidadeController.text) ?? 0.0;

      final novoAluno = Aluno(
        id: widget.aluno?.id, // Utiliza o id se o aluno estiver sendo editado
        nome: nome,
        diaPagamento:
            _diaPagamento ?? 0, // Certifique-se de ter um valor padrão
        endereco: endereco,
        valorMensalidade: valorMensalidade,
      );

      final alunoProvider = Provider.of<AlunoProvider>(context, listen: false);

      if (widget.aluno == null) {
        // Adiciona novo aluno
        await alunoProvider.adicionarAluno(novoAluno);
      } else {
        // Edita aluno existente
        await alunoProvider.atualizarAluno(novoAluno);
      }

      Navigator.pop(context); // Retorna à lista após salvar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.aluno == null ? 'Cadastrar Aluno' : 'Editar Aluno',
          style: const TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold, // Opcional: para deixar o texto em negrito
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 73, 97),
      ),
      backgroundColor: const Color.fromARGB(255, 1, 73, 97),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 1, 73, 97),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Borda branca quando o campo não está focado
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0), // Borda branca quando o campo está focado
                  ),
                ),
                style: TextStyle(color: Colors.white), // Cor do texto digitado
                cursorColor: Colors.white, // Cor do cursor
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _diaPagamento,
                decoration: const InputDecoration(
                  labelText: 'Dia de Pagamento',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 1, 73, 97),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Borda branca quando o campo não está focado
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0), // Borda branca quando o campo está focado
                  ),
                ),
                style: TextStyle(color: Colors.white), // Cor do texto digitado
                //cursorColor: Colors.white, // Cor do cursor
                items: List.generate(
                  29,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text((index + 1).toString(),
                        style: const TextStyle(color: Colors.black)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _diaPagamento = value;
                  });
                },

                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o dia de pagamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 1, 73, 97),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Borda branca quando o campo não está focado
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0), // Borda branca quando o campo está focado
                  ),
                ),
                style: TextStyle(color: Colors.white), // Cor do texto digitado
                cursorColor: Colors.white, // Cor do cursor
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorMensalidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Valor da Mensalidade',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color.fromARGB(255, 1, 73, 97),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Borda branca quando o campo não está focado
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width:
                              2.0), // Borda branca quando o campo está focado
                    ),
                    prefixText: 'R\$ ',
                    prefixStyle:
                        TextStyle(color: Colors.white) // Adiciona o cifrão
                    ),
                style: TextStyle(color: Colors.white), // Cor do texto digitado
                cursorColor: Colors.white, // Cor do cursor
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor da mensalidade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarAluno,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Cor de fundo
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.aluno == null ? 'Cadastrar' : 'Salvar Alterações',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Cor da fonte
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

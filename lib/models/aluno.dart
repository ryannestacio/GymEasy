class Aluno {
  final int? id;
  final String nome;
  final int diaPagamento; // Dia do mês em que o pagamento deve ser feito
  final String endereco;
  final double valorMensalidade;
  final DateTime dataVencimento; // Alterado para não aceitar nulo
  List<bool> mesesPagos; // Adicione esta linha

  Aluno({
    this.id,
    required this.nome,
    required this.diaPagamento,
    required this.endereco,
    required this.valorMensalidade,
    DateTime? dataVencimento, // Altere para opcional
  })  : dataVencimento =
            dataVencimento ?? DateTime.now(), // Define um valor padrão
        mesesPagos = List.filled(12, false); // Inicializa a lista com 12 meses
}

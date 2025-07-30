import 'package:farmastock/modelo/base_modal.dart';

class ProdutoModelo extends BaseModel {
  final String nome;
  final String? codigoBarras;
  final String unidadeMedida;
  final int quantidadeAtual;
  final int quantidadeMinima;
  final double precoCusto;
  final double precoVenda;

  ProdutoModelo({
    String? id,
    required this.nome,
    this.codigoBarras,
    required this.unidadeMedida,
    this.quantidadeAtual = 0,
    this.quantidadeMinima = 0,
    required this.precoCusto,
    required this.precoVenda,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        'codigo_barras': codigoBarras,
        'unidade_medida': unidadeMedida,
        'quantidade_atual': quantidadeAtual,
        'quantidade_minima': quantidadeMinima,
        'preco_custo': precoCusto,
        'preco_venda': precoVenda,
      };

  static ProdutoModelo fromMap(Map<String, dynamic> map) => ProdutoModelo(
        id: map['id'],
        nome: map['nome'],
        codigoBarras: map['codigo_barras'],
        unidadeMedida: map['unidade_medida'],
        quantidadeAtual: map['quantidade_atual'] ?? 0,
        quantidadeMinima: map['quantidade_minima'] ?? 0,
        precoCusto: (map['preco_custo'] as num).toDouble(),
        precoVenda: (map['preco_venda'] as num).toDouble(),
      );
}

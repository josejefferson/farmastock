import 'package:farmastock/modelo/base_modal.dart';

class EntradaEstoqueModelo extends BaseModel {
  final String produtoId;
  final String fornecedor;
  final int quantidade;
  final double precoCustoUnitario;
  final double precoVendaUnitario;
  final DateTime? dataValidade;
  final DateTime dataEntrada;

  EntradaEstoqueModelo({
    String? id,
    required this.produtoId,
    required this.fornecedor,
    required this.quantidade,
    required this.precoCustoUnitario,
    required this.precoVendaUnitario,
    this.dataValidade,
    DateTime? dataEntrada,
  })  : dataEntrada = dataEntrada ?? DateTime.now(),
        super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'produto_id': produtoId,
        'fornecedor': fornecedor,
        'quantidade': quantidade,
        'preco_custo_unitario': precoCustoUnitario,
        'preco_venda_unitario': precoVendaUnitario,
        'data_validade': dataValidade?.toIso8601String(),
        'data_entrada': dataEntrada.toIso8601String(),
      };

  static EntradaEstoqueModelo fromMap(Map<String, dynamic> map) => EntradaEstoqueModelo(
        id: map['id'],
        produtoId: map['produto_id'],
        fornecedor: map['fornecedor'],
        quantidade: map['quantidade'],
        precoCustoUnitario: (map['preco_custo_unitario'] as num).toDouble(),
        precoVendaUnitario: (map['preco_venda_unitario'] as num).toDouble(),
        dataValidade: map['data_validade'] != null
            ? DateTime.tryParse(map['data_validade'])
            : null,
        dataEntrada: DateTime.parse(map['data_entrada']),
      );
}

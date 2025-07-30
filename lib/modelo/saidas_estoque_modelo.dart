import 'package:farmastock/modelo/base_modal.dart';

class SaidaEstoqueModelo extends BaseModel {
  final String produtoId;
  final String tipoSaida;
  final int quantidade;
  final double precoCustoUnitario;
  final double? precoVendaUnitario;
  final DateTime dataSaida;

  SaidaEstoqueModelo({
    String? id,
    required this.produtoId,
    required this.tipoSaida,
    required this.quantidade,
    required this.precoCustoUnitario,
    this.precoVendaUnitario,
    DateTime? dataSaida,
  })  : dataSaida = dataSaida ?? DateTime.now(),
        super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'produto_id': produtoId,
        'tipo_saida': tipoSaida,
        'quantidade': quantidade,
        'preco_custo_unitario': precoCustoUnitario,
        'preco_venda_unitario': precoVendaUnitario,
        'data_saida': dataSaida.toIso8601String(),
      };

  static SaidaEstoqueModelo fromMap(Map<String, dynamic> map) =>
      SaidaEstoqueModelo(
        id: map['id'],
        produtoId: map['produto_id'],
        tipoSaida: map['tipo_saida'],
        quantidade: map['quantidade'],
        precoCustoUnitario: (map['preco_custo_unitario'] as num).toDouble(),
        precoVendaUnitario: map['preco_venda_unitario'] != null
            ? (map['preco_venda_unitario'] as num).toDouble()
            : null,
        dataSaida: DateTime.parse(map['data_saida']),
      );
}

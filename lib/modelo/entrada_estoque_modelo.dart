import 'package:hive/hive.dart';

part 'entrada_estoque.g.dart';

@HiveType(typeId: 6)
class EntradaEstoque {
  @HiveField(0)
  String id;

  @HiveField(1)
  String produtoId;

  @HiveField(2)
  String fornecedor;

  @HiveField(3)
  int quantidade;

  @HiveField(4)
  double precoCustoUnitario;

  @HiveField(5)
  double precoVendaUnitario;

  @HiveField(6)
  String? dataValidade;

  @HiveField(7)
  String dataEntrada; 

  EntradaEstoque({
    this.id,
    required this.produtoId,
    required this.fornecedor,
    required this.quantidade,
    required this.precoCustoUnitario,
    required this.precoVendaUnitario,
    this.dataValidade,
    required this.dataEntrada,
  }): id = id ?? const Uuid().v4();
}

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'saidas_estoque_modelo.g.dart';

@HiveType(typeId: 7)
class SaidaEstoque {
  @HiveField(0)
  String id;

  @HiveField(1)
  String produtoId;

  @HiveField(2)
  TipoSaidaEstoque tipoSaida; 

  @HiveField(3)
  int quantidade;

  @HiveField(4)
  double precoCustoUnitario;

  @HiveField(5)
  double? precoVendaUnitario;

  @HiveField(6)
  String dataSaida;

  SaidaEstoque({
    id,
    required this.produtoId,
    required this.tipoSaida,
    required this.quantidade,
    required this.precoCustoUnitario,
    this.precoVendaUnitario,
    required this.dataSaida,
  }): id = id ?? const Uuid().v4();
}

@HiveType(typeId: 8)
enum TipoSaidaEstoque {
  @HiveField(0)
  venda,
  
  @HiveField(1)
  perda,
  
  @HiveField(2)
  usoInterno,
}
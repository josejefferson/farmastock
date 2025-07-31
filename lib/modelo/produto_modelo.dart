import 'package:hive/hive.dart';

part 'produto.g.dart';

@HiveType(typeId: 4)
class Produto {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  String? codigoBarras;

  @HiveField(3)
  UnidadeMedida unidadeMedida; 

  @HiveField(4)
  int quantidadeAtual;

  @HiveField(5)
  int quantidadeMinima;

  @HiveField(6)
  double precoCusto;

  @HiveField(7)
  double precoVenda;

  Produto({
    this.id,
    required this.nome,
    required this.codigoBarras,
    required this.unidadeMedida,
    required this.quantidadeAtual,
    required this.quantidadeMinima,
    required this.precoCusto,
    required this.precoVenda,
  }): id = id ?? const Uuid().v4();
}

@HiveType(typeId: 5)
enum UnidadeMedida {
  @HiveField(0)
  mg,
  @HiveField(1)
  g,
  @HiveField(2)
  kg,
  @HiveField(3)
  mL,
  @HiveField(4)
  L,
  @HiveField(5)
  un,
}

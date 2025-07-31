import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'dados_farmacia.g.dart';

@HiveType(typeId: 3)

// extends HiveObject
class DadosFarmacia  {
    @HiveField(0)
    String id;

    @HiveField(1)
    String nomeFarmacia;

    @HiveField(2)
    String cnpj;

    @HiveField(3)
    String? email;

    @HiveField(4)
    String? telefone;

    DadosFarmacia({
        String? id,
        required this.nomeFarmacia,
        required this.cnpj,
        required this.email,
        required this.telefone,
    }) : id = id ?? const Uuid().v4();
}

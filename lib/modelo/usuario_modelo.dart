import 'package:farmastock/modelo/base_modal.dart';


part 'usuario_modelo.g.dart';

@HiveType(typeId: 1)
class UsuarioModelo {
  
  @HiveField(0)
  final String id;
  // = const Uuid().v4();
  
  @HiveField(1)
  final String nome;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String senha;
  
  @HiveField(4)
  final UsuarioRole role;

  @HiveField(5)
  final String cpf;

  UsuarioModelo({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.role = UsuarioRole.user,
    required this.cpf,
  }): id = id ?? const Uuid().v4();
}

@HiveType(typeId: 2)
enum UsuarioRole {
  @HiveField(0)
  admin,
  @HiveField(1) 
  user,
}
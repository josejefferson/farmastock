import 'package:farmastock/modelo/base_modal.dart';

class UsuarioModelo extends BaseModel {
  final String nome;
  final String email;
  final String senha;
  final String role;

  UsuarioModelo({
    String? id,
    required this.nome,
    required this.email,
    required this.senha,
    this.role = 'usuarioModelo',
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'role': role,
    };
  }

  static UsuarioModelo fromMap(Map<String, dynamic> map) {
    return UsuarioModelo(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      role: map['role'],
      criadoEm: DateTime.parse(map['criado_em']),
      atualizadoEm: DateTime.parse(map['atualizado_em']),
    );
  }
}

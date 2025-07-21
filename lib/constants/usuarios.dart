class Usuario {
  final String nome;
  final String email;
  final bool isAdmin;

  Usuario({required this.nome, required this.email, this.isAdmin = false});
}

final usuarios = [
  Usuario(nome: 'Marcos Paulo', email: 'marcospaulo@email.com', isAdmin: true),
  Usuario(nome: 'Kayo Ronald', email: 'kayoronald@email.com'),
  Usuario(nome: 'José Jefferson', email: 'josejefferson@email.com'),
];

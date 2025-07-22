import 'package:flutter/material.dart';

class EditarUsuarioPage extends StatefulWidget {
  const EditarUsuarioPage({super.key});

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController(
    text: 'João Silva',
  );
  final TextEditingController cpfController = TextEditingController(
    text: '000.000.000-00',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'joao@farmacia.com',
  );
  final TextEditingController nivelController = TextEditingController(
    text: 'Admin',
  );

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final nome = nomeController.text;
      // final cpf = cpfController.text;
      // final email = emailController.text;
      // final nivel = nivelController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário "$nome" salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar "João Silva"')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // Nome
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Informe o nome'
                              : null,
                ),
                const SizedBox(height: 16),

                // CPF
                TextFormField(
                  controller: cpfController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Informe o CPF';
                    if (!RegExp(
                      r'^\d{3}\.\d{3}\.\d{3}-\d{2}$',
                    ).hasMatch(value)) {
                      return 'CPF inválido (ex: 000.000.000-00)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // E-mail
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o e-mail';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Nível
                TextFormField(
                  controller: nivelController,
                  decoration: const InputDecoration(
                    labelText: 'Nível',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Informe o nível'
                              : null,
                ),
                const SizedBox(height: 32),

                // Botão Salvar
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[200],
                    ),
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

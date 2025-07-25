import 'package:br_validators/br_validators.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                // Nome
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome';
                    }
                    return null;
                  },
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Informe o CPF';

                    if (!BRValidators.validateCPF(value)) {
                      return 'CPF inválido';
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

                    if (!isEmail(value)) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Nível
                // TODO: Colocar dropdown
                TextFormField(
                  controller: nivelController,
                  decoration: const InputDecoration(
                    labelText: 'Nível',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nível do usuário';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Botão Salvar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
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

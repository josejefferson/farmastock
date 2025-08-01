import 'package:br_validators/br_validators.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:farmastock/constants/niveis.dart';
import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class EditarUsuarioPage extends StatefulWidget {
  final UsuarioModelo? usuario;

  const EditarUsuarioPage({super.key, this.usuario});

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController = TextEditingController(
    text: widget.usuario?.nome ?? '',
  );

  late final TextEditingController cpfController = TextEditingController(
    text: widget.usuario?.cpf ?? '',
  );

  late final TextEditingController emailController = TextEditingController(
    text: widget.usuario?.email ?? '',
  );

  late final TextEditingController senhaController = TextEditingController(
    text: '',
  );

  late UsuarioRole nivel = widget.usuario?.role ?? UsuarioRole.user;

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      bool senhaDefinida = senhaController.text.isNotEmpty;

      final usuario = UsuarioModelo(
        id: widget.usuario?.id,
        nome: nomeController.text,
        cpf: cpfController.text,
        email: emailController.text,
        senha: senhaDefinida ? senhaController.text : widget.usuario!.senha,
        role: nivel,
      );

      usuariosBox.put(usuario.id, usuario);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário "${usuario.nome}" salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.usuario == null
              ? 'Adicionar usuário'
              : 'Editar "${widget.usuario?.nome}"',
        ),
      ),
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

                // Senha
                TextFormField(
                  controller: senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    hintText:
                        widget.usuario != null
                            ? 'Deixe em branco para manter a senha atual'
                            : null,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null ||
                        widget.usuario == null && (value.isEmpty)) {
                      return 'Informe a senha';
                    }

                    if (value.isNotEmpty && value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Nível
                DropdownButtonFormField<UsuarioRole>(
                  decoration: InputDecoration(
                    labelText: 'Nível de acesso',
                    border: OutlineInputBorder(),
                  ),
                  value: nivel,
                  items:
                      niveis.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role.name),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() => nivel = value!);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione um nível de acesso';
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

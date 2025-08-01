import 'package:br_validators/br_validators.dart';
import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/dados_farmacia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';
import 'package:brasil_fields/brasil_fields.dart';

class DadosDaFarmaciaPage extends StatefulWidget {
  const DadosDaFarmaciaPage({super.key});

  @override
  State<DadosDaFarmaciaPage> createState() => _DadosDaFarmaciaPageState();
}

class _DadosDaFarmaciaPageState extends State<DadosDaFarmaciaPage> {
  final DadosFarmacia? dadosFarmacia = dadosFarmaciaBox.getAt(0);
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nomeController = TextEditingController(
    text: dadosFarmacia?.nomeFarmacia ?? '',
  );

  late final TextEditingController cnpjController = TextEditingController(
    text: dadosFarmacia?.cnpj ?? '',
  );

  late final TextEditingController emailController = TextEditingController(
    text: dadosFarmacia?.email ?? '',
  );

  late final TextEditingController telefoneController = TextEditingController(
    text: dadosFarmacia?.telefone ?? '',
  );

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final dadosFarmacia = DadosFarmacia(
        nomeFarmacia: nomeController.text,
        cnpj: cnpjController.text,
        email: emailController.text,
        telefone: telefoneController.text,
      );

      dadosFarmaciaBox.putAt(0, dadosFarmacia);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Farmácia "${dadosFarmacia.nomeFarmacia}" salvo com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados da Farmácia')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16.0,
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome da Farmácia',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome da farmácia';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cnpjController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNPJ',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CnpjInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o CNPJ';
                    }

                    if (!BRValidators.validateCNPJ(value)) {
                      return 'CNPJ inválido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail';
                    }

                    if (!isEmail(value)) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: telefoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefone',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }

                    if (!BRValidators.validateMobileNumber(value)) {
                      return 'Telefone inválido';
                    }

                    return null;
                  },
                ),
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

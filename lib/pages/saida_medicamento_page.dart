import 'package:brasil_fields/brasil_fields.dart';
import 'package:farmastock/constants/produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

class SaidaMedicamentoPage extends StatefulWidget {
  const SaidaMedicamentoPage({super.key});

  @override
  State<SaidaMedicamentoPage> createState() => _SaidaMedicamentoPageState();
}

class _SaidaMedicamentoPageState extends State<SaidaMedicamentoPage> {
  final _formKey = GlobalKey<FormState>();

  String? produtoSelecionado;
  final fornecedorController = TextEditingController();
  final quantidadeController = TextEditingController();
  final precoCustoController = TextEditingController();
  final validadeController = TextEditingController();
  final precoVendaController = TextEditingController();

  @override
  void dispose() {
    fornecedorController.dispose();
    quantidadeController.dispose();
    precoCustoController.dispose();
    validadeController.dispose();
    precoVendaController.dispose();
    super.dispose();
  }

  void _salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode enviar os dados para um backend ou salvar localmente
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Formulário salvo com sucesso!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saída de "Omeprazol 20mg"')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16.0,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Produto',
                    border: OutlineInputBorder(),
                  ),
                  value: produtoSelecionado,
                  items:
                      produtos.map((produto) {
                        return DropdownMenuItem(
                          value: produto,
                          child: Text(produto),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() => produtoSelecionado = value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecione um produto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: fornecedorController,
                  decoration: InputDecoration(
                    labelText: 'Fornecedor',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o fornecedor';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quantidadeController,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a quantidade';
                    }

                    final number = int.tryParse(value);
                    if (number == null || number <= 0) {
                      return 'Quantidade inválida';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: precoCustoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço de Custo',
                    prefix: Text('R\$ '),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço de custo';
                    }
                    if (!isFloat(value)) {
                      return 'Preço de custo deve ser um número válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: validadeController,
                  decoration: InputDecoration(
                    labelText: 'Validade',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de validade';
                    }

                    final date = DateFormat('dd/MM/yyyy').tryParse(value);
                    if (date == null) {
                      return 'Data inválida. Use o formato dd/MM/yyyy';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: precoVendaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço de Venda',
                    prefix: Text('R\$ '),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço de venda';
                    }
                    if (!isFloat(value)) {
                      return 'Preço de venda deve ser um número válido';
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
                    onPressed: _salvarFormulario,
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

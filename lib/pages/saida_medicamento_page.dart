import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Saída de "Omeprazol 20mg"')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Produto'),
                  value: produtoSelecionado,
                  items:
                      ['Omeprazol 20mg', 'Dipirona 500mg']
                          .map(
                            (produto) => DropdownMenuItem(
                              value: produto,
                              child: Text(produto),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => produtoSelecionado = value),
                  validator:
                      (value) => value == null ? 'Selecione um produto' : null,
                ),
                TextFormField(
                  controller: fornecedorController,
                  decoration: InputDecoration(labelText: 'Fornecedor'),
                  validator:
                      (value) => value!.isEmpty ? 'Informe o fornecedor' : null,
                ),
                TextFormField(
                  controller: quantidadeController,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe a quantidade';
                    final number = int.tryParse(value);
                    return number == null || number <= 0
                        ? 'Quantidade inválida'
                        : null;
                  },
                ),
                TextFormField(
                  controller: precoCustoController,
                  decoration: InputDecoration(
                    labelText: 'Preço de custo (R\$)',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o preço de custo';
                    final number = double.tryParse(value.replaceAll(',', '.'));
                    return number == null ? 'Preço inválido' : null;
                  },
                ),
                TextFormField(
                  controller: validadeController,
                  decoration: InputDecoration(labelText: 'Validade'),
                  keyboardType: TextInputType.datetime,
                  validator:
                      (value) => value!.isEmpty ? 'Informe a validade' : null,
                ),
                TextFormField(
                  controller: precoVendaController,
                  decoration: InputDecoration(
                    labelText: 'Preço de venda (R\$)',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) return 'Informe o preço de venda';
                    final number = double.tryParse(value.replaceAll(',', '.'));
                    return number == null ? 'Preço inválido' : null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _salvarFormulario,
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

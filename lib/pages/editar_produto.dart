import 'package:farmastock/constants/unidades.dart';
import 'package:farmastock/widgets/components/auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class EditarProdutoPage extends StatefulWidget {
  const EditarProdutoPage({super.key});

  @override
  State<EditarProdutoPage> createState() => _EditarProdutoPageState();
}

class _EditarProdutoPageState extends State<EditarProdutoPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar "Dipirona 500mg"')),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do Produto',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do produto';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código de Barras',
                  ),
                  buildCounter: (
                    context, {
                    required currentLength,
                    required isFocused,
                    required maxLength,
                  }) {
                    // Oculta o contador de caracteres
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 13,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o código de barras';
                    }

                    if (value.length != 13) {
                      return 'Código de barras deve ter 13 dígitos';
                    }

                    return null;
                  },
                ),

                RawAutocomplete<String>(
                  optionsBuilder: autoCompleteOptionsBuilder(unidades),
                  optionsViewBuilder: autoCompleteViewBuilder,
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Unidade de Medida',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a unidade de medida';
                        }
                        return null;
                      },
                    );
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade Atual',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade atual';
                    }
                    if (!isInt(value)) {
                      return 'Quantidade deve ser um número inteiro';
                    }
                    if (int.parse(value) < 0) {
                      return 'Quantidade não pode ser negativa';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantidade Mínima',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade mínima';
                    }
                    if (!isInt(value)) {
                      return 'Quantidade mínima deve ser um número inteiro';
                    }
                    if (int.parse(value) < 0) {
                      return 'Quantidade mínima não pode ser negativa';
                    }
                    return null;
                  },
                ),

                TextFormField(
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
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {}
                    },
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

import 'package:farmastock/constants/unidades.dart';
import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/produto_modelo.dart';
import 'package:farmastock/widgets/components/auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class EditarProdutoPage extends StatefulWidget {
  final Produto? produto;

  const EditarProdutoPage({super.key, this.produto});

  @override
  State<EditarProdutoPage> createState() => _EditarProdutoPageState();
}

class _EditarProdutoPageState extends State<EditarProdutoPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nomeController = TextEditingController(
    text: widget.produto?.nome ?? '',
  );

  final nomeFocusNode = FocusNode();

  late final TextEditingController codBarrasController = TextEditingController(
    text: widget.produto?.codigoBarras ?? '',
  );

  late UnidadeMedida unidadeMedida =
      widget.produto?.unidadeMedida ?? UnidadeMedida.un;

  late final TextEditingController quantidadeAtualController =
      TextEditingController(
        text: widget.produto?.quantidadeAtual.toString() ?? '',
      );

  late final TextEditingController quantidadeMinimaController =
      TextEditingController(
        text: widget.produto?.quantidadeMinima.toString() ?? '',
      );

  late final TextEditingController precoCustoController = TextEditingController(
    text: widget.produto?.precoCusto.toString() ?? '',
  );

  late final TextEditingController precoVendaController = TextEditingController(
    text: widget.produto?.precoVenda.toString() ?? '',
  );

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final produto = Produto(
        id: widget.produto?.id,
        nome: nomeController.text,
        codigoBarras: codBarrasController.text,
        unidadeMedida: unidadeMedida,
        quantidadeAtual: int.parse(quantidadeAtualController.text),
        quantidadeMinima: int.parse(quantidadeMinimaController.text),
        precoCusto: double.parse(precoCustoController.text),
        precoVenda: double.parse(precoVendaController.text),
      );

      produtoBox.put(produto.id, produto);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto "${produto.nome}" salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.produto == null
              ? 'Adicionar produto'
              : 'Editar "${widget.produto?.nome}"',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16.0,
              children: [
                RawAutocomplete<String>(
                  optionsBuilder: autoCompleteOptionsBuilder(
                    produtosAPIBox.get('produtos') ?? [],
                  ),
                  focusNode: nomeFocusNode,
                  optionsViewBuilder: autoCompleteViewBuilder,
                  textEditingController: nomeController,
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
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
                    );
                  },
                ),

                TextFormField(
                  controller: codBarrasController,
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

                DropdownButtonFormField<UnidadeMedida>(
                  decoration: InputDecoration(
                    labelText: 'Unidade de Medida',
                    border: OutlineInputBorder(),
                  ),
                  value: unidadeMedida,
                  items:
                      unidades.map((unidade) {
                        return DropdownMenuItem(
                          value: unidade,
                          child: Text(unidade.name),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() => unidadeMedida = value!);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma unidade de medida';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: quantidadeAtualController,
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
                  controller: quantidadeMinimaController,
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

import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/pages/entrada_medicamento_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class EntradaEstoquePage extends StatefulWidget {
  const EntradaEstoquePage({super.key});

  @override
  State<EntradaEstoquePage> createState() => _EntradaEstoquePageState();
}

class _EntradaEstoquePageState extends State<EntradaEstoquePage> {
  @override
  void initState() {
    entradaEstoqueBox.listenable().addListener(_onBoxChanged);
    super.initState();
  }

  @override
  void dispose() {
    entradaEstoqueBox.listenable().removeListener(_onBoxChanged);
    super.dispose();
  }

  void _onBoxChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final entradaFiltrado =
        entradaEstoqueBox.values
            .where(
              (entrada) => produtoBox.values.any(
                (produto) => produto.id == entrada.produtoId,
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Entradas de Estoque')),
      body: SafeArea(
        child: ListView.separated(
          itemCount: entradaFiltrado.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final entrada = entradaFiltrado.elementAt(index);

            final produto = produtoBox.values.firstWhereOrNull(
              (p) => p.id == entrada.produtoId,
            );

            if (produto == null) {
              return const Text("Não há produtos cadastrados");
            }

            final dataFormatada = DateFormat(
              'dd/MM/yyyy',
            ).format(DateTime.parse(entrada.dataEntrada));
            return ListTile(
              title: Text(produto.nome),
              subtitle: Text(
                "${entrada.quantidade} - ${produto.unidadeMedida.name}",
              ),
              trailing: Text(dataFormatada),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EntradaMedicamentoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

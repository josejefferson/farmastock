import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/pages/entrada_medicamento_page.dart';
import 'package:farmastock/widgets/components/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class EntradaEstoquePage extends StatelessWidget {
  const EntradaEstoquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entradas de Estoque')),
      body: ValueListenableBuilder(
        valueListenable: entradaEstoqueBox.listenable(),
        builder: (context, box, child) {
          final entradaFiltrado =
              box.values
                  .where(
                    (entrada) => produtoBox.values.any(
                      (produto) => produto.id == entrada.produtoId,
                    ),
                  )
                  .toList();

          return SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: kFloatingActionButtonMargin + kMinInteractiveDimension,
              ),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      Text(dataFormatada),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        tooltip: 'Excluir',
                        onPressed: () async {
                          bool confirmado = await confirmDialog(context);
                          if (!confirmado) return;
                          await box.delete(entrada.id);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Entrada de estoque excluída'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
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

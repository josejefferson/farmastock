import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:farmastock/pages/saida_medicamento_page.dart';
import 'package:farmastock/widgets/components/confirm_dialog.dart';
import 'package:farmastock/widgets/components/info_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class SaidaEstoquePage extends StatelessWidget {
  const SaidaEstoquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saída de Estoque')),
      body: ValueListenableBuilder(
        valueListenable: saidasEstoqueBox.listenable(),
        builder: (context, box, child) {
          final saidas = box.values.toList();

          final totalVenda = saidas
              .where((s) => s.tipoSaida == TipoSaidaEstoque.venda)
              .fold<double>(
                0.0,
                (soma, s) =>
                    soma +
                    (s.quantidade *
                        (s.precoVendaUnitario - s.precoCustoUnitario)),
              );

          final totalPerdas = saidas
              .where((s) => s.tipoSaida == TipoSaidaEstoque.perda)
              .fold<double>(
                0.0,
                (soma, s) =>
                    soma +
                    (s.quantidade *
                        (s.precoVendaUnitario - s.precoCustoUnitario)),
              );

          final totalUsoInterno = saidas
              .where((s) => s.tipoSaida == TipoSaidaEstoque.usoInterno)
              .fold<double>(
                0.0,
                (soma, s) =>
                    soma +
                    (s.quantidade *
                        (s.precoVendaUnitario - s.precoCustoUnitario)),
              );

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: kFloatingActionButtonMargin + kMinInteractiveDimension,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoCard(
                        texto: 'Total em Vendas',
                        valor: NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                        ).format(totalVenda),
                        cor: Colors.greenAccent,
                        icon: Icons.shopping_cart,
                      ),
                      const SizedBox(height: 12),
                      InfoCard(
                        texto: 'Perdas',
                        valor: NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                        ).format(totalPerdas),
                        cor: Colors.redAccent,
                        icon: Icons.warning,
                      ),
                      const SizedBox(height: 12),
                      InfoCard(
                        texto: 'Uso Interno',
                        valor: NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                        ).format(totalUsoInterno),
                        cor: Colors.blueAccent,
                        icon: Icons.medical_services,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Itens",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: box.values.length,
                  separatorBuilder:
                      (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final saida = box.values.elementAt(index);
                    final produto = produtoBox.values.firstWhereOrNull(
                      (p) => p.id == saida.produtoId,
                    );
                    if (produto == null) {
                      return const Text("Não há produtos cadastrados");
                    }
                    final dataFormatada = DateFormat(
                      'dd/MM/yyyy',
                    ).format(DateTime.parse(saida.dataSaida));
                    return ListTile(
                      title: Text(produto.nome),
                      subtitle: Text(saida.tipoSaida.name),
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
                              await box.delete(saida.id);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Saída de estoque excluída'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SaidaMedicamentoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

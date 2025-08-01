import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:farmastock/pages/saida_medicamento_page.dart';
import 'package:farmastock/widgets/components/info_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class SaidaEstoquePage extends StatefulWidget {
  const SaidaEstoquePage({super.key});

  @override
  State<SaidaEstoquePage> createState() => _SaidaEstoquePageState();
}

class _SaidaEstoquePageState extends State<SaidaEstoquePage> {
  @override
  void initState() {
    saidasEstoqueBox.listenable().addListener(_onBoxChanged);
    super.initState();
  }

  @override
  void dispose() {
    saidasEstoqueBox.listenable().removeListener(_onBoxChanged);
    super.dispose();
  }

  void _onBoxChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final saidas = saidasEstoqueBox.values.toList();

    final totalVenda = saidas
        .where((s) => s.tipoSaida == TipoSaidaEstoque.venda)
        .fold<double>(
          0.0,
          (soma, s) => soma + (s.quantidade * s.precoCustoUnitario),
        );

    final totalPerdas = saidas
        .where((s) => s.tipoSaida == TipoSaidaEstoque.perda)
        .fold<double>(
          0.0,
          (soma, s) => soma + (s.quantidade * s.precoCustoUnitario),
        );

    final totalUsoInterno = saidas
        .where((s) => s.tipoSaida == TipoSaidaEstoque.usoInterno)
        .fold<double>(
          0.0,
          (soma, s) => soma + (s.quantidade * s.precoCustoUnitario),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Saída de Estoque')),
      body: SingleChildScrollView(
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
                    valor: 'R\$ ${totalVenda.toStringAsFixed(2)}',
                    cor: Colors.greenAccent,
                    icon: Icons.shopping_cart,
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    texto: 'Perdas',
                    valor: 'R\$ ${totalPerdas.toStringAsFixed(2)}',
                    cor: Colors.redAccent,
                    icon: Icons.warning,
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    texto: 'Uso Interno',
                    valor: 'R\$ ${totalUsoInterno.toStringAsFixed(2)}',
                    cor: Colors.blueAccent,
                    icon: Icons.medical_services,
                  ),
                  const SizedBox(height: 24),
                  Text("Itens", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: saidasEstoqueBox.values.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final saida = saidasEstoqueBox.values.elementAt(index);
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
                  trailing: Text(dataFormatada),
                );
              },
            ),
          ],
        ),
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

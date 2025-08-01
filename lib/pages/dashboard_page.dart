import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/widgets/components/appbar.dart';
import 'package:farmastock/widgets/components/drawer.dart';
import 'package:farmastock/widgets/components/info_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        usuarioLogadoBox.listenable(),
        usuariosBox.listenable(),
        dadosFarmaciaBox.listenable(),
        entradaEstoqueBox.listenable(),
        produtoBox.listenable(),
        saidasEstoqueBox.listenable(),
      ]),
      builder: (context, child) {
        final usuarioLogado = usuarioLogadoBox.get('usuarioLogado');
        final nomeUsuario = usuarioLogado?.nome ?? '?';

        // Hive
        final produtos = produtoBox.values.toList();
        final entradas = entradaEstoqueBox.values.toList();
        final saidas = saidasEstoqueBox.values.toList();

        final produtosComEstoqueBaixo =
            produtos
                .where((p) => p.quantidadeAtual <= p.quantidadeMinima)
                .length;

        final hoje = DateTime.now();
        final trintaDiasDepois = hoje.add(const Duration(days: 30));

        final produtosComVencimentoProximo =
            entradaEstoqueBox.values.where((entrada) {
              if (entrada.dataValidade == null) return false;

              final dataVal = DateTime.tryParse(entrada.dataValidade!);
              if (dataVal == null) return false;

              return dataVal.isAfter(hoje) &&
                  dataVal.isBefore(trintaDiasDepois);
            }).length;

        final entradasDoMes = entradas.length;
        final saidasDoMes = saidas.length;

        return Scaffold(
          appBar: MyAppBar(),
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem-vindo $nomeUsuario",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    texto: "Produtos com estoque baixo",
                    valor: "$produtosComEstoqueBaixo",
                    icon: Icons.warning_amber_rounded,
                    cor: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    texto: "Produtos com vencimento próximo",
                    valor: "$produtosComVencimentoProximo",
                    icon: Icons.warning_amber_rounded,
                    cor: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    texto: "Entradas do mês",
                    valor: "$entradasDoMes",
                    icon: Icons.trending_up,
                    cor: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    texto: "Saídas do mês",
                    valor: "$saidasDoMes",
                    icon: Icons.trending_down,
                    cor: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

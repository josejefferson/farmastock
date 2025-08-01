import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/data/seed.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/catalogo_produto_page.dart';
import 'package:farmastock/pages/editar_produto_page.dart';
import 'package:farmastock/pages/editar_usuario_page.dart';
import 'package:farmastock/pages/entrada_estoque_page.dart';
import 'package:farmastock/pages/login_page.dart';
import 'package:farmastock/pages/saida_estoque.dart';
import 'package:farmastock/pages/usuarios_page.dart';
import 'package:farmastock/widgets/components/info_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = usuarioLogadoBox.get('usuarioLogado');
    final nomeUsuario = usuarioLogado?.nome ?? '?';
    final letraUsuario = nomeUsuario[0].toUpperCase();

    // Hive
    final produtos = produtoBox.values.toList();
    final entradas = entradaEstoqueBox.values.toList();
    final saidas = saidasEstoqueBox.values.toList();

    final produtosComEstoqueBaixo =
        produtos.where((p) => p.quantidadeAtual <= p.quantidadeMinima).length;

    final hoje = DateTime.now();
    final trintaDiasDepois = hoje.add(const Duration(days: 30));

    final produtosComVencimentoProximo =
        entradaEstoqueBox.values.where((entrada) {
          if (entrada.dataValidade == null) return false;

          final dataVal = DateTime.tryParse(entrada.dataValidade!);
          if (dataVal == null) return false;

          return dataVal.isAfter(hoje) && dataVal.isBefore(trintaDiasDepois);
        }).length;

    final entradasDoMes = entradas.length;
    final saidasDoMes = saidas.length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.medication,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            const Text(
              "FarmaStock",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: PopupMenuButton<String>(
              tooltip: nomeUsuario,
              itemBuilder:
                  (context) => [
                    PopupMenuItem<String>(value: 'logout', child: Text('Sair')),
                  ],
              onSelected: (value) {
                if (value == 'logout') {
                  usuarioLogadoBox.delete('usuarioLogado');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  letraUsuario,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Editar Produto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditarProdutoPage(),
                  ),
                );
              },
            ),

            if (usuarioLogado != null &&
                usuarioLogado.role == UsuarioRole.admin)
              ListTile(
                title: const Text('Usuários'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsuariosPage(),
                    ),
                  );
                },
              ),
            if (usuarioLogado != null &&
                usuarioLogado.role == UsuarioRole.admin)
              ListTile(
                title: const Text('Editar Usuário'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditarUsuarioPage(),
                    ),
                  );
                },
              ),
            // ListTile(
            //   title: const Text('Saída de Medicamento'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const SaidaMedicamentoPage(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('Entrada de estoque'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntradaEstoquePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            // ListTile(
            //   title: const Text('Entrada de medicamento'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const EntradaMedicamentoPage(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('Saida estoque'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaidaEstoquePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Catálogo produto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatalogoProdutoPage(),
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                return ListTile(
                  title: const Text('[DEV] Seed Database'),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    seedManual(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
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
  }
}

import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/catalogo_produto_page.dart';
import 'package:farmastock/pages/editar_produto_page.dart';
import 'package:farmastock/pages/editar_usuario_page.dart';
import 'package:farmastock/pages/entrada_medicamento_page.dart';
import 'package:farmastock/pages/login_page.dart';
import 'package:farmastock/pages/saida_estoque.dart';
import 'package:farmastock/pages/saida_medicamento_page.dart';
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
            ListTile(
              title: const Text('Saída de Medicamento'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaidaMedicamentoPage(),
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
            ListTile(
              title: const Text('Entrada de medicamento'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntradaMedicamentoPage(),
                  ),
                );
              },
            ),
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
              const InfoCard(
                texto: "Produtos com estoque baixo",
                valor: "12",
                icon: Icons.warning_amber_rounded,
                cor: Colors.red,
              ),
              const SizedBox(height: 16),
              const InfoCard(
                texto: "Produtos com vencimento próximo",
                valor: "8",
                icon: Icons.warning_amber_rounded,
                cor: Colors.red,
              ),
              const SizedBox(height: 16),
              const InfoCard(
                texto: "Entradas do mês",
                valor: "156",
                icon: Icons.trending_up,
                cor: Colors.green,
              ),
              const SizedBox(height: 16),
              const InfoCard(
                texto: "Saídas do mês",
                valor: "243",
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

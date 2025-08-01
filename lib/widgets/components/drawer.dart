import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/data/seed.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/catalogo_produto_page.dart';
import 'package:farmastock/pages/dados_da_farmacia_page.dart';
import 'package:farmastock/pages/entrada_estoque_page.dart';
import 'package:farmastock/pages/saida_estoque.dart';
import 'package:farmastock/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = usuarioLogadoBox.get('usuarioLogado');

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (usuarioLogado != null &&
                usuarioLogado.role == UsuarioRole.admin)
              ListTile(
                title: const Text('Usuários'),
                leading: const Icon(Icons.people_outline_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsuariosPage(),
                    ),
                  );
                },
              ),

            ListTile(
              title: const Text('Entradas de estoque'),
              leading: const Icon(Icons.inventory_outlined),
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
              title: const Text('Saídas de Estoque'),
              leading: const Icon(Icons.exit_to_app_outlined),
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
              title: const Text('Produtos'),
              leading: const Icon(Icons.shopping_bag_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatalogoProdutoPage(),
                  ),
                );
              },
            ),

            if (usuarioLogado != null &&
                usuarioLogado.role == UsuarioRole.admin)
              ListTile(
                title: const Text('Dados da Farmácia'),
                leading: const Icon(Icons.local_hospital_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DadosDaFarmaciaPage(),
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
    );
  }
}

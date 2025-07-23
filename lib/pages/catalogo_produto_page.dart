import 'package:farmastock/constants/exemplo_produtos.dart';
import 'package:farmastock/pages/editar_produto_page.dart';
import 'package:flutter/material.dart';

class CatalogoProdutoPage extends StatelessWidget {
  const CatalogoProdutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Produtos')),
      body: ListView.separated(
        itemCount: produtosExemplo.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final produto = produtosExemplo[index];
          final estoque = produto['estoque'] as int;
          final minimo = produto['minimo'] as int;
          return ListTile(
            title: Text(produto['nome']! as String),
            subtitle: Text.rich(
              TextSpan(
                text: 'Estoque: ',
                children: [
                  TextSpan(
                    text: '$estoque',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(text: ' / Mínimo: $minimo'),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Aumentar estoque',
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  onPressed: () {},
                  tooltip: 'Diminuir estoque',
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: 'Editar',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  tooltip: 'Excluir',
                  onPressed: () {},
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
            MaterialPageRoute(builder: (context) => const EditarProdutoPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

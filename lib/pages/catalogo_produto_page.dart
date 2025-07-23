import 'package:farmastock/constants/exemplo_produtos.dart';
import 'package:farmastock/pages/editar_produto_page.dart';
import 'package:flutter/material.dart';

class CatalogoProdutoPage extends StatelessWidget {
  const CatalogoProdutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas de Estoque'),
      ),
      body: ListView.separated(
        itemCount: produtosExemplo.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final produto = produtosExemplo[index];
          final estoque = produto['estoque'] as int;
          final minimo = produto['minimo'] as int;
          return ListTile(
            title: Text(
              produto['nome']! as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text.rich(
              TextSpan(
                text: 'Estoque: ',
                children: [
                  TextSpan(
                    text: '$estoque',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.pink),
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
              builder: (context) => const EditarProdutoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/pages/editar_produto_page.dart';
import 'package:farmastock/widgets/components/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CatalogoProdutoPage extends StatelessWidget {
  const CatalogoProdutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Produtos')),
      body: ValueListenableBuilder(
        valueListenable: produtoBox.listenable(),
        builder: (context, box, child) {
          return ListView.separated(
            padding: EdgeInsets.only(
              bottom: kFloatingActionButtonMargin + kMinInteractiveDimension,
            ),
            itemCount: box.values.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final produto = box.values.elementAt(index);
              final estoque = produto.quantidadeAtual;
              final minimo = produto.quantidadeMinima;

              return ListTile(
                title: Text(produto.nome),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Estoque: ',
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: '$estoque',
                            style: TextStyle(
                              color:
                                  produto.quantidadeAtual <
                                          produto.quantidadeMinima
                                      ? Colors.red
                                      : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Mínimo: $minimo'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Diminuir estoque',
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed:
                          produto.quantidadeAtual <= 0
                              ? null
                              : () {
                                produto.quantidadeAtual--;
                                box.put(produto.id, produto);
                              },
                    ),

                    IconButton(
                      tooltip: 'Aumentar estoque',
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        produto.quantidadeAtual++;
                        box.put(produto.id, produto);
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).colorScheme.primary,
                      tooltip: 'Editar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditarProdutoPage(produto: produto);
                            },
                          ),
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      tooltip: 'Excluir',
                      onPressed: () async {
                        bool confirmado = await confirmDialog(context);
                        if (!confirmado) return;
                        await box.delete(produto.id);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Produto "${produto.nome}" excluído'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
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

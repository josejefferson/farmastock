import 'package:farmastock/constants/exemplo_produtos.dart';
import 'package:farmastock/pages/entrada_medicamento_page.dart';
import 'package:flutter/material.dart';

class EntradaEstoquePage extends StatelessWidget {
  const EntradaEstoquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas de Estoque'),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: produtosExemplo.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final produto = produtosExemplo[index];
            return ListTile(
              title: Text(
                produto['nome']! as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(produto['descricao']! as String),
              trailing: Text(produto['dataEntrada']! as String),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EntradaMdicamentoPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

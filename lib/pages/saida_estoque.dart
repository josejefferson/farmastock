import 'package:farmastock/constants/exemplo_produtos.dart';
import 'package:farmastock/pages/saida_medicamento_page.dart';
import 'package:farmastock/widgets/components/info_card.dart';
import 'package:flutter/material.dart';

class SaidaEstoquePage extends StatelessWidget {
  const SaidaEstoquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saída de Estoque'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InfoCard(
                texto: 'Total em Vendas',
                valor: 'R\$ 70.90',
                cor: Colors.greenAccent,
                icon: Icons.shopping_cart,
              ),
              InfoCard(
                texto: 'Perdas',
                valor: 'R\$ 89.00',
                cor: Colors.redAccent,
                icon: Icons.warning,
              ),
              const SizedBox(height: 12),
              const InfoCard(
                texto: 'Uso Interno',
                cor: Colors.blueAccent,
                icon: Icons.medical_services,
                valor: 'R\$ 22.80',
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: produtosExemplo.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final produto = produtosExemplo[index];
                  return ListTile(
                    title: Text(
                      produto['nome']! as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(produto['tipoSaida']! as String),
                    trailing: Text(produto['dataSaida']! as String),
                  );
                },
              ),
            ],
          ),
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

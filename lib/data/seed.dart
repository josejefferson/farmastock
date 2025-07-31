import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/dados_farmacia.dart';
import 'package:farmastock/modelo/produto_modelo.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/modelo/entrada_estoque_modelo.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:flutter/material.dart';

Future<void> seedManual(BuildContext context) async {
  try {
    await seedInicial();
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Seed do banco de dados concluído')));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Erro ao executar seed do banco de dados: $e')));
  }
}

Future<void> seedInicial() async {
  await usuariosBox.clear();
  await dadosFarmaciaBox.clear();
  await produtoBox.clear();
  await entradaEstoqueBox.clear();
  await saidasEstoqueBox.clear();

  final usuarios = [
    UsuarioModelo(
      nome: 'Jefferson Dantas',
      email: 'jefferson.dantas@example.com',
      senha: 'jefferson.dantas',
      role: UsuarioRole.user,
      cpf: '222.222.222-22',
    ),
    UsuarioModelo(
      nome: 'Marcos Paulo',
      email: 'marcos.paulo@gmail.com',
      senha: 'marcos.paulo',
      role: UsuarioRole.admin,
      cpf: '111.111.111-11',
    ),
  ];

  print("SEED: Usuários...");
  for (var usuario in usuarios) {
    if (!usuariosBox.containsKey(usuario.id)) {
      await usuariosBox.put(usuario.id, usuario);
    }
  }

  final farmacia = DadosFarmacia(
    nomeFarmacia: "Farmácia Popular",
    cnpj: "00.000.000/0001-00",
    email: "farmacia.popular@gmail.com",
    telefone: "(83) 99999-9999",
  );

  print("Farmácia...");
  if (!dadosFarmaciaBox.containsKey(farmacia.id)) {
    await dadosFarmaciaBox.put(farmacia.id, farmacia);
  }

  final produtos = [
    Produto(
      nome: 'Paracetamol 500mg',
      codigoBarras: '7891234567890',
      unidadeMedida: UnidadeMedida.un,
      quantidadeAtual: 100,
      quantidadeMinima: 20,
      precoCusto: 5.00,
      precoVenda: 10.00,
    ),
    Produto(
      nome: 'Dipirona 1g',
      codigoBarras: '7890987654321',
      unidadeMedida: UnidadeMedida.un,
      quantidadeAtual: 50,
      quantidadeMinima: 10,
      precoCusto: 8.00,
      precoVenda: 15.00,
    ),
    Produto(
      nome: 'Amoxicilina 500mg',
      codigoBarras: '7891112223334',
      unidadeMedida: UnidadeMedida.un,
      quantidadeAtual: 70,
      quantidadeMinima: 15,
      precoCusto: 3.50,
      precoVenda: 7.00,
    ),
    Produto(
      nome: 'Ibuprofeno 600mg',
      codigoBarras: '7895556667778',
      unidadeMedida: UnidadeMedida.un,
      quantidadeAtual: 80,
      quantidadeMinima: 20,
      precoCusto: 4.20,
      precoVenda: 8.50,
    ),
  ];

  print("SEED: Produtos...");
  for (var produto in produtos) {
    if (!produtoBox.containsKey(produto.id)) {
      await produtoBox.put(produto.id, produto);
    }
  }

  final todosProdutos = produtoBox.values.toList();

  final entradas = [
    EntradaEstoque(
      produtoId: todosProdutos[0].id,
      fornecedor: 'Fornecedor A',
      quantidade: 50,
      precoCustoUnitario: 4.50,
      precoVendaUnitario: 9.50,
      dataValidade: '2026-12-31',
      dataEntrada: '2025-07-01',
    ),
    EntradaEstoque(
      produtoId: todosProdutos[1].id,
      fornecedor: 'Fornecedor B',
      quantidade: 30,
      precoCustoUnitario: 7.80,
      precoVendaUnitario: 14.00,
      dataValidade: '2025-11-30',
      dataEntrada: '2025-07-02',
    ),
    EntradaEstoque(
      produtoId: todosProdutos[2].id,
      fornecedor: 'Fornecedor C',
      quantidade: 40,
      precoCustoUnitario: 3.20,
      precoVendaUnitario: 6.50,
      dataValidade: '2025-10-10',
      dataEntrada: '2025-07-03',
    ),
    EntradaEstoque(
      produtoId: todosProdutos[3].id,
      fornecedor: 'Fornecedor D',
      quantidade: 60,
      precoCustoUnitario: 4.00,
      precoVendaUnitario: 8.00,
      dataValidade: '2025-09-15',
      dataEntrada: '2025-07-04',
    ),
  ];

  print("SEED: Entradas de estoque...");
  for (var entrada in entradas) {
    if (!entradaEstoqueBox.containsKey(entrada.id)) {
      await entradaEstoqueBox.put(entrada.id, entrada);
    }
  }

  final saidas = [
    SaidaEstoque(
      produtoId: todosProdutos[0].id,
      tipoSaida: TipoSaidaEstoque.venda,
      quantidade: 5,
      precoCustoUnitario: 4.50,
      precoVendaUnitario: 9.50,
      dataSaida: '2025-07-10',
    ),
    SaidaEstoque(
      produtoId: todosProdutos[1].id,
      tipoSaida: TipoSaidaEstoque.perda,
      quantidade: 2,
      precoCustoUnitario: 7.80,
      precoVendaUnitario: 14.00,
      dataSaida: '2025-07-11',
    ),
    SaidaEstoque(
      produtoId: todosProdutos[2].id,
      tipoSaida: TipoSaidaEstoque.usoInterno,
      quantidade: 3,
      precoCustoUnitario: 3.20,
      precoVendaUnitario: 6.50,
      dataSaida: '2025-07-12',
    ),
  ];

  print("SEED: Saídas de estoque...");
  for (var saida in saidas) {
    if (!saidasEstoqueBox.containsKey(saida.id)) {
      await saidasEstoqueBox.put(saida.id, saida);
    }
  }

  print("Seed finalizado com sucesso!");
}

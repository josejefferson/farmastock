import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/dados_farmacia.dart';
import 'package:farmastock/modelo/entrada_estoque_modelo.dart';
import 'package:farmastock/modelo/produto_modelo.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UsuarioModeloAdapter());
  Hive.registerAdapter(DadosFarmaciaAdapter());
  Hive.registerAdapter(EntradaEstoqueAdapter());
  Hive.registerAdapter(ProdutoAdapter());
  Hive.registerAdapter(SaidaEstoqueAdapter());

  usuariosBox = await Hive.openBox<UsuarioModelo>('usuariosBox');
  dadosFarmaciaBox = await Hive.openBox<DadosFarmacia>('dadosFarmaciaBox');
  entradaEstoqueBox = await Hive.openBox<EntradaEstoque>('entradaEstoqueBox');
  produtoBox = await Hive.openBox<Produto>('produtoBox');
  saidasEstoqueBox = await Hive.openBox<SaidaEstoque>('saidasEstoqueBox');

  // final directory = await getApplicationDocumentsDirectory();
  // Hive.defaultDirectory = directory.path;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmaStock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardPage(),
    );
  }
}

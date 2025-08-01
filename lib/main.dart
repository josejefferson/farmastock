import 'dart:io' show Platform;

import 'package:farmastock/data/boxes.dart';
import 'package:farmastock/modelo/dados_farmacia.dart';
import 'package:farmastock/modelo/entrada_estoque_modelo.dart';
import 'package:farmastock/modelo/produto_modelo.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:farmastock/pages/dashboard_page.dart';
import 'package:farmastock/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && Platform.isWindows) {
    final dir = await getApplicationSupportDirectory();
    await Hive.initFlutter(dir.path);
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(UsuarioModeloAdapter());
  Hive.registerAdapter(UsuarioRoleAdapter());
  Hive.registerAdapter(DadosFarmaciaAdapter());
  Hive.registerAdapter(EntradaEstoqueAdapter());
  Hive.registerAdapter(ProdutoAdapter());
  Hive.registerAdapter(UnidadeMedidaAdapter());
  Hive.registerAdapter(SaidaEstoqueAdapter());
  Hive.registerAdapter(TipoSaidaEstoqueAdapter());

  usuariosBox = await Hive.openBox<UsuarioModelo>('usuariosBox');
  dadosFarmaciaBox = await Hive.openBox<DadosFarmacia>('dadosFarmaciaBox');
  entradaEstoqueBox = await Hive.openBox<EntradaEstoque>('entradaEstoqueBox');
  produtoBox = await Hive.openBox<Produto>('produtoBox');
  saidasEstoqueBox = await Hive.openBox<SaidaEstoque>('saidasEstoqueBox');
  usuarioLogadoBox = await Hive.openBox<UsuarioModelo>('usuarioLogadoBox');

  if (usuariosBox.isEmpty) {
    usuarioLogadoBox.put(
      'usuarioLogado',
      UsuarioModelo(
        nome: 'Usuário temporário',
        email: 'temp@user.com',
        senha: '123',
        cpf: '123.456.789-00',
        role: UsuarioRole.admin,
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = usuarioLogadoBox.get('usuarioLogado');

    return MaterialApp(
      title: 'FarmaStock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: usuarioLogado == null ? const LoginPage() : const DashboardPage(),
    );
  }
}

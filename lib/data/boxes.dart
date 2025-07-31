import 'package:farmastock/modelo/dados_farmacia.dart';
import 'package:farmastock/modelo/entrada_estoque_modelo.dart';
import 'package:farmastock/modelo/produto_modelo.dart';
import 'package:farmastock/modelo/saidas_estoque_modelo.dart';
import 'package:farmastock/modelo/usuario_modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<UsuarioModelo> usuariosBox;
late Box<DadosFarmacia> dadosFarmaciaBox;
late Box<EntradaEstoque> entradaEstoqueBox;
late Box<Produto> produtoBox;
late Box<SaidaEstoque> saidasEstoqueBox;

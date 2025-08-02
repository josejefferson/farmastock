import 'dart:io' show HttpClient;

import 'package:csv/csv.dart';
import 'package:farmastock/data/boxes.dart';
import 'package:http/io_client.dart';

Future<List<String>> fetchMedicamentos() async {
  final url =
      'https://dados.anvisa.gov.br/dados/DADOS_ABERTOS_MEDICAMENTOS.csv';

  final ioClient = IOClient(
    HttpClient()..badCertificateCallback = (cert, host, port) => true,
  );

  // Não funciona na Web, pois há erro de CORS
  final response = await ioClient.get(Uri.parse(url));

  if (response.statusCode != 200) throw Exception('Falha');
  final csvString = response.body;

  // final file = File('lib/DADOS_ABERTOS_MEDICAMENTOS.csv');
  // final csvBytes = await file.readAsBytes();
  // final csvString = latin1.decode(csvBytes);

  final csvRows = const CsvToListConverter(
    fieldDelimiter: ';',
    eol: '\n',
  ).convert(csvString);

  final nomesMedicamentos =
      csvRows.skip(1).map((row) => (row[1] as String).trim()).toList();
  final medicamentosUnicos = nomesMedicamentos.toSet().toList();
  return medicamentosUnicos.cast<String>();
}

void atualizarRepositorioMedicamentos() async {
  final ultimaAtualizacao = produtosAPIBox.get('ultimaAtualizacao');

  if (ultimaAtualizacao != null &&
      DateTime.now().difference(DateTime.parse(ultimaAtualizacao)).inDays < 7) {
    print('Repositório de medicamentos atualizado recentemente');
    return;
  }

  try {
    final medicamentos = await fetchMedicamentos();
    produtosAPIBox.put('ultimaAtualizacao', DateTime.now().toIso8601String());
    produtosAPIBox.put('produtos', medicamentos);
    print('Repositório de medicamentos atualizado com sucesso');
  } catch (e) {
    print('Erro ao atualizar repositório de medicamentos: $e');
    return;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saidas_estoque_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaidaEstoqueAdapter extends TypeAdapter<SaidaEstoque> {
  @override
  final int typeId = 7;

  @override
  SaidaEstoque read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaidaEstoque(
      id: fields[0] as dynamic,
      produtoId: fields[1] as String,
      tipoSaida: fields[2] as TipoSaidaEstoque,
      quantidade: fields[3] as int,
      precoCustoUnitario: fields[4] as double,
      precoVendaUnitario: fields[5] as double,
      dataSaida: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaidaEstoque obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.produtoId)
      ..writeByte(2)
      ..write(obj.tipoSaida)
      ..writeByte(3)
      ..write(obj.quantidade)
      ..writeByte(4)
      ..write(obj.precoCustoUnitario)
      ..writeByte(5)
      ..write(obj.precoVendaUnitario)
      ..writeByte(6)
      ..write(obj.dataSaida);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaidaEstoqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TipoSaidaEstoqueAdapter extends TypeAdapter<TipoSaidaEstoque> {
  @override
  final int typeId = 8;

  @override
  TipoSaidaEstoque read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TipoSaidaEstoque.venda;
      case 1:
        return TipoSaidaEstoque.perda;
      case 2:
        return TipoSaidaEstoque.usoInterno;
      default:
        return TipoSaidaEstoque.venda;
    }
  }

  @override
  void write(BinaryWriter writer, TipoSaidaEstoque obj) {
    switch (obj) {
      case TipoSaidaEstoque.venda:
        writer.writeByte(0);
        break;
      case TipoSaidaEstoque.perda:
        writer.writeByte(1);
        break;
      case TipoSaidaEstoque.usoInterno:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoSaidaEstoqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

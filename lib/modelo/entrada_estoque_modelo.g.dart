// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrada_estoque_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntradaEstoqueAdapter extends TypeAdapter<EntradaEstoque> {
  @override
  final int typeId = 6;

  @override
  EntradaEstoque read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntradaEstoque(
      id: fields[0] as dynamic,
      produtoId: fields[1] as String,
      fornecedor: fields[2] as String,
      quantidade: fields[3] as int,
      precoCustoUnitario: fields[4] as double,
      precoVendaUnitario: fields[5] as double,
      dataValidade: fields[6] as String?,
      dataEntrada: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EntradaEstoque obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.produtoId)
      ..writeByte(2)
      ..write(obj.fornecedor)
      ..writeByte(3)
      ..write(obj.quantidade)
      ..writeByte(4)
      ..write(obj.precoCustoUnitario)
      ..writeByte(5)
      ..write(obj.precoVendaUnitario)
      ..writeByte(6)
      ..write(obj.dataValidade)
      ..writeByte(7)
      ..write(obj.dataEntrada);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntradaEstoqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

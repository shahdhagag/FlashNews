// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_response.dart';


class SourceResponseAdapter extends TypeAdapter<SourceResponse> {
  @override
  final int typeId = 0;

  @override
  SourceResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceResponse(
      status: fields[0] as String?,
      sources: (fields[1] as List?)?.cast<Sources>(),
      message: fields[2] as String?,
      code: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.sources)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.code);
  }
}

class SourcesAdapter extends TypeAdapter<Sources> {
  @override
  final int typeId = 1;

  @override
  Sources read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sources(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      url: fields[3] as String?,
      category: fields[4] as String?,
      language: fields[5] as String?,
      country: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Sources obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.country);
  }
}

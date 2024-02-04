// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordModel _$RecordModelFromJson(Map<String, dynamic> json) => RecordModel(
      id: json['id'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      item: $enumDecode(_$RecordItemEnumMap, json['item']),
      name: json['name'] as String,
      ml: json['ml'] as int,
      goal: json['goal'] as int,
    );

Map<String, dynamic> _$RecordModelToJson(RecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'time': instance.time,
      'item': _$RecordItemEnumMap[instance.item]!,
      'name': instance.name,
      'ml': instance.ml,
      'goal': instance.goal
    };

const _$RecordItemEnumMap = {
  RecordItem.water: 'water',
  RecordItem.drinks: 'drinks',
  RecordItem.coffee: 'coffee',
  RecordItem.tea: 'tea',
  RecordItem.milk: 'milk',
  RecordItem.customization: 'customization',
};

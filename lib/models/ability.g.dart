// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return Ability(
    displayName: json['displayName'] as String,
    description: json['description'] as String,
    displayIcon: json['displayIcon'] as String,
  );
}

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'description': instance.description,
      'displayIcon': instance.displayIcon,
    };

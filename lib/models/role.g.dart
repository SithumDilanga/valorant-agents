// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    displayName: json['displayName'] as String,
    description: json['description'] as String,
    displayIcon: json['displayIcon'] as String,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'description': instance.description,
      'displayIcon': instance.displayIcon,
    };

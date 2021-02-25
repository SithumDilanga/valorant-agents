// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agent _$AgentFromJson(Map<String, dynamic> json) {
  return Agent(
    uuid: json['uuid'] as String,
    displayName: json['displayName'] as String,
    displayIcon: json['displayIcon'] as String,
    description: json['description'] as String,
    fullPortrait: json['fullPortrait'] as String,
    role: json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
    abilities: (json['abilities'] as List)
        ?.map((e) =>
            e == null ? null : Ability.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    characterTags: json['characterTags'] as List,
  );
}

Map<String, dynamic> _$AgentToJson(Agent instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'displayName': instance.displayName,
      'displayIcon': instance.displayIcon,
      'description': instance.description,
      'fullPortrait': instance.fullPortrait,
      'role': instance.role,
      'abilities': instance.abilities,
      'characterTags': instance.characterTags,
    };

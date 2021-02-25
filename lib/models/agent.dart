import 'dart:core';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:valorant_agents/models/ability.dart';
import 'package:valorant_agents/models/role.dart';

/// This allows the `Agent` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'agent.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class Agent {

  final String uuid;
  final String displayName;
  final String displayIcon;
  final String description;
  final String fullPortrait;
  final Role role;
  final List<Ability> abilities;
  final List characterTags;

  const Agent({
    @required this.uuid, 
    @required this.displayName,
    @required this.displayIcon,
    @required this.description,
    @required this.fullPortrait,
    @required this.role,
    @required this.abilities,
    @required this.characterTags
  }) : assert(uuid != null),
       assert(displayName != null),
       assert(displayIcon != null),
       assert(description != null),
       assert(abilities != null);

  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);

  Map<String, dynamic> toJson() => _$AgentToJson(this);

}
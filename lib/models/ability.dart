import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()

class Ability {

  final String displayName;
  final String description;
  final String displayIcon;

  Ability({
    this.displayName, 
    this.description, 
    this.displayIcon
  });
  // : assert(displayName != null),
      //  assert(description != null),
      //  assert(displayIcon != null);

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);

}
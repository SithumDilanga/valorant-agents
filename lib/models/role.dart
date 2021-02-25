import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';
@JsonSerializable()

class Role {

  final String displayName;
  final String description;
  final String displayIcon;

  Role({
    @required this.displayName, 
    @required this.description, 
    @required this.displayIcon
  }) : assert(displayName != null),
       assert(description != null),
       assert(displayIcon != null);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
  
}
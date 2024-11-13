import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;
  
  @JsonKey(name: "email")
  String? email;

  @JsonKey(name:'passward')
  String? passward;
  
  User({
    this.id,
    this.name,
    this.email,
     required String passward
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
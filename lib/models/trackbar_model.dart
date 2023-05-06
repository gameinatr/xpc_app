import 'package:json_annotation/json_annotation.dart';
part 'trackbar_model.g.dart';

@JsonSerializable()
class Trackbar {
  @JsonKey(name: 'total_xp')
  int totalXp;
  @JsonKey(name: 'total_xxp')
  int totalXxp;
  @JsonKey(name: 'earned_xp')
  int earnedXp;
  @JsonKey(name: 'earned_xxp')
  int earnedXxp;

  Trackbar(
      {required this.totalXp,
      required this.totalXxp,
      required this.earnedXp,
      required this.earnedXxp});

  factory Trackbar.fromJson(Map<String, dynamic> json) =>
      _$TrackbarFromJson(json);

  Map<String, dynamic> toJson() => _$TrackbarToJson(this);
}

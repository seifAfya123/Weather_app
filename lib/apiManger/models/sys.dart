import 'package:collection/collection.dart';

class Sys {
  int? type;
  int? id;
  double? message;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.type,
    this.id,
    this.message,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'] as int?,
        id: json['id'] as int?,
        message: (json['message'] as num?)?.toDouble(),
        country: json['country'] as String?,
        sunrise: json['sunrise'] as int?,
        sunset: json['sunset'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'message': message,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Sys) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      message.hashCode ^
      country.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode;
}

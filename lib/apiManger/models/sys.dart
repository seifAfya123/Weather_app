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
}

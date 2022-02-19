import 'package:collection/collection.dart';

class Wind {
  double? speed;
  int? deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] as num?)?.toDouble(),
        deg: json['deg'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Wind) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => speed.hashCode ^ deg.hashCode;
}

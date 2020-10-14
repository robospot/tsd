import 'dart:convert';
class SsccModel {
  String eanDescription;
  int ssccCount;
  int eanCount;
  SsccModel({
    this.eanDescription,
    this.ssccCount,
    this.eanCount,
  });

  SsccModel copyWith({
    int ssccCount,
    int eanCount,
  }) {
    return SsccModel(
      ssccCount: ssccCount ?? this.ssccCount,
      eanCount: eanCount ?? this.eanCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eanDescription': eanDescription,
      'ssccCount': ssccCount,
      'eanCount': eanCount,
    };
  }

  factory SsccModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SsccModel(
      eanDescription: map['eanDescription'],
      ssccCount: map['ssccCount'],
      eanCount: map['eanCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SsccModel.fromJson(String source) =>
      SsccModel.fromMap(json.decode(source));

  @override
  String toString() => 'SsccModel(ssccCount: $ssccCount, eanCount: $eanCount, eanDescripton: $eanDescription)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SsccModel &&
        o.ssccCount == ssccCount &&
        o.eanCount == eanCount &&
        o.eanDescription == eanDescription;
  }

  @override
  int get hashCode =>
      ssccCount.hashCode ^ eanCount.hashCode ^ eanDescription.hashCode;
}

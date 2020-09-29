import 'dart:convert';

class SsccModel {
  int ssccCount;
  int eanCount;
  SsccModel({
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
      'ssccCount': ssccCount,
      'eanCount': eanCount,
    };
  }

  factory SsccModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SsccModel(
      ssccCount: map['ssccCount'],
      eanCount: map['eanCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SsccModel.fromJson(String source) => SsccModel.fromMap(json.decode(source));

  @override
  String toString() => 'SsccModel(ssccCount: $ssccCount, eanCount: $eanCount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SsccModel &&
      o.ssccCount == ssccCount &&
      o.eanCount == eanCount;
  }

  @override
  int get hashCode => ssccCount.hashCode ^ eanCount.hashCode;
}

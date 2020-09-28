import 'dart:convert';

class Sscc {
  int organization;
  String sscc;
  String ean;
  String datamatrix;
  bool isUsed;
  String createdAt;
  String updatedAt;
  Sscc({
    this.organization,
    this.sscc,
    this.ean,
    this.datamatrix,
    this.isUsed,
    this.createdAt,
    this.updatedAt,
  });

  Sscc copyWith({
    int organization,
    String sscc,
    String ean,
    String datamatrix,
    bool isUsed,
    String createdAt,
    String updatedAt,
  }) {
    return Sscc(
      organization: organization ?? this.organization,
      sscc: sscc ?? this.sscc,
      ean: ean ?? this.ean,
      datamatrix: datamatrix ?? this.datamatrix,
      isUsed: isUsed ?? this.isUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'organization': organization,
      'sscc': sscc,
      'ean': ean,
      'datamatrix': datamatrix,
      'isUsed': isUsed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Sscc.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Sscc(
      organization: map['organization'],
      sscc: map['sscc'],
      ean: map['ean'],
      datamatrix: map['datamatrix'],
      isUsed: map['isUsed'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sscc.fromJson(String source) => Sscc.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Sscc(organization: $organization, sscc: $sscc, ean: $ean, datamatrix: $datamatrix, isUsed: $isUsed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Sscc &&
      o.organization == organization &&
      o.sscc == sscc &&
      o.ean == ean &&
      o.datamatrix == datamatrix &&
      o.isUsed == isUsed &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return organization.hashCode ^
      sscc.hashCode ^
      ean.hashCode ^
      datamatrix.hashCode ^
      isUsed.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

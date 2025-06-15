
class ProductAttributesDTO {
  final String atrName1;
  final String atr1;
  final String atrName2;
  final String atr2;
  final String atrName3;
  final String atr3;
  final String atrName4;
  final String atr4;
  final String atrName5;
  final String atr5;
  final String atrName6;
  final String atr6;
  final String atrName7;
  final String atr7;
  final String atrName8;
  final String atr8;
  final String atrName9;
  final String atr9;
  final String atrName10;
  final String atr10;

  ProductAttributesDTO({
    required this.atrName1,
    required this.atr1,
    required this.atrName2,
    required this.atr2,
    required this.atrName3,
    required this.atr3,
    required this.atrName4,
    required this.atr4,
    required this.atrName5,
    required this.atr5,
    required this.atrName6,
    required this.atr6,
    required this.atrName7,
    required this.atr7,
    required this.atrName8,
    required this.atr8,
    required this.atrName9,
    required this.atr9,
    required this.atrName10,
    required this.atr10,
  });

  factory ProductAttributesDTO.fromJson(Map<String, dynamic> json) {
    return ProductAttributesDTO(
      atrName1: json['atrName1'] ?? '',
      atr1:      json['atr1']      ?? '',
      atrName2: json['atrName2'] ?? '',
      atr2:      json['atr2']      ?? '',
      atrName3: json['atrName3'] ?? '',
      atr3:      json['atr3']      ?? '',
      atrName4: json['atrName4'] ?? '',
      atr4:      json['atr4']      ?? '',
      atrName5: json['atrName5'] ?? '',
      atr5:      json['atr5']      ?? '',
      atrName6: json['atrName6'] ?? '',
      atr6:      json['atr6']      ?? '',
      atrName7: json['atrName7'] ?? '',
      atr7:      json['atr7']      ?? '',
      atrName8: json['atrName8'] ?? '',
      atr8:      json['atr8']      ?? '',
      atrName9: json['atrName9'] ?? '',
      atr9:      json['atr9']      ?? '',
      atrName10: json['atrName10'] ?? '',
      atr10:     json['atr10']     ?? '',
    );
  }

  factory ProductAttributesDTO.empty() => ProductAttributesDTO(
    atrName1: '',
    atr1: '',
    atrName2: '',
    atr2: '',
    atrName3: '',
    atr3: '',
    atrName4: '',
    atr4: '',
    atrName5: '',
    atr5: '',
    atrName6: '',
    atr6: '',
    atrName7: '',
    atr7: '',
    atrName8: '',
    atr8: '',
    atrName9: '',
    atr9: '',
    atrName10: '',
    atr10: '',
  );
}
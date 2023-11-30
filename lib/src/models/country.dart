class Country {
  int? id;
  String? name;
  String? code1;
  String? code2;

  Country({this.id, this.name, this.code1, this.code2});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code1 = json['code1'];
    code2 = json['code2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code1'] = code1;
    data['code2'] = code2;
    return data;
  }
}

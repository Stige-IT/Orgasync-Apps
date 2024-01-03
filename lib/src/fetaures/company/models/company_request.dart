part of '../company.dart';

class CompanyRequest {
  final String name;
  final int size;
  final String typeCompany;

  CompanyRequest({
    required this.name,
    required this.size,
    required this.typeCompany,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "size": size,
      "type": typeCompany,
    };
  }
}

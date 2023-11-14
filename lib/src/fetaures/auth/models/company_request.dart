part of "../auth.dart";

class CompanyRequest {
  final String name;
  final String email;
  final String password;
  final String country;
  final int size;
  final String typeCompany;

  CompanyRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.size,
    required this.typeCompany,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "country": country,
      "size": size,
      "type_company": typeCompany,
    };
  }
}

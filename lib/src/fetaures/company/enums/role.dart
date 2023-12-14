part of "../company.dart";

enum Role {
  admin("admin"),
  member("member"),
  owner("owner");

  const Role(this.value);
  final String value;
}

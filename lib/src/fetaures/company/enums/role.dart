part of "../company.dart";

enum Role {
  admin("admin"),
  owner("owner"),
  member("member"),
  guest("guest");

  const Role(this.value);
  final String value;
}

part of "../company.dart";

final idTypeCompanyProvider = StateProvider<String?>((ref) => null);

final typeCompaniesNotifier =
    StateNotifierProvider<TypeNotifier, States<List<TypeCompany>>>((ref) {
  return TypeNotifier(ref.watch(typeCompanyProvider));
});

part of "../../user.dart";

class FormUserAddressWidget extends ConsumerStatefulWidget {
  const FormUserAddressWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormUserAddressWidgetState();
}

class _FormUserAddressWidgetState extends ConsumerState<FormUserAddressWidget> {
  late TextEditingController _addressCtrl;
  late TextEditingController _zipCodeCtrl;

  @override
  void initState() {
    _addressCtrl = TextEditingController();
    _zipCodeCtrl = TextEditingController();
    Future.microtask(() {
      ref.read(countryNotifier.notifier).get();
      ref.read(provinceNotifier.notifier).get();
      ref.read(addressNotifier.notifier).get();
      final userdata = ref.watch(addressNotifier).data;
      _addressCtrl.text = userdata?.street ?? "";
      _zipCodeCtrl.text = userdata?.zipCode.toString() ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    _addressCtrl.dispose();
    _zipCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(editAddressNotifier).isLoading;
    final countries = ref.watch(countryNotifier).data;
    final provincies = ref.watch(provinceNotifier).data;
    final cities = ref.watch(cityNotifier).data;
    final districts = ref.watch(districtNotifier).data;
    final subdistricts = ref.watch(subdistrictNotifier).data;
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        ListTile(
          leading: const Icon(Icons.add_location_alt_outlined),
          title: Text("change_address".tr()),
        ),
        DropdownContainer(
          title: "country".tr(),
          value: ref.watch(idCountryProvider),
          items: (countries ?? [])
              .map((country) => DropdownMenuItem<int>(
                    value: country.id,
                    child: Text(country.name ?? ""),
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(idCountryProvider.notifier).state = value;
          },
        ),
        DropdownContainer(
          title: "province".tr(),
          value: ref.watch(idProvinceProvider),
          items: (provincies ?? [])
              .map((province) => DropdownMenuItem<int>(
                    value: province.id,
                    child: Text(province.name ?? ""),
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(idProvinceProvider.notifier).state = value;
            ref.read(cityNotifier.notifier).get(title: "regency", id: value);

            ref.invalidate(idCityProvider);

            ref.invalidate(idDistrictProvider);
            ref.invalidate(districtNotifier);

            ref.invalidate(idSubdistrictProvider);
            ref.invalidate(subdistrictNotifier);
          },
        ),
        DropdownContainer(
          title: "city".tr(),
          value: ref.watch(idCityProvider),
          items: (cities ?? [])
              .map((city) => DropdownMenuItem<int>(
                    value: city.id,
                    child: Text(city.name ?? ""),
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(idCityProvider.notifier).state = value;
            ref
                .read(districtNotifier.notifier)
                .get(title: "district", id: value);

            ref.invalidate(idDistrictProvider);

            ref.invalidate(idSubdistrictProvider);
            ref.invalidate(subdistrictNotifier);
          },
        ),
        DropdownContainer(
          title: "district".tr(),
          value: ref.watch(idDistrictProvider),
          items: (districts ?? [])
              .map((district) => DropdownMenuItem<int>(
                    value: district.id,
                    child: Text(district.name ?? ""),
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(idDistrictProvider.notifier).state = value;
            ref
                .read(subdistrictNotifier.notifier)
                .get(title: "village", id: value);

            ref.invalidate(idSubdistrictProvider);
          },
        ),
        DropdownContainer(
          title: "sub_district".tr(),
          value: ref.watch(idSubdistrictProvider),
          items: (subdistricts ?? [])
              .map((subDistrict) => DropdownMenuItem<int>(
                    value: subDistrict.id,
                    child: Text(subDistrict.name ?? ""),
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(idSubdistrictProvider.notifier).state = value;
          },
        ),
        FieldInput(
          title: "street_address".tr(),
          hintText: "input_street_address",
          controllers: _addressCtrl,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
        ),
        FieldInput(
          title: "zip_code".tr(),
          hintText: "input_zip_code".tr(),
          controllers: _zipCodeCtrl,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              if (isLoading) return;
              final request = AddressRequest(
                country: ref.watch(idCountryProvider),
                province: ref.watch(idProvinceProvider),
                regency: ref.watch(idCityProvider),
                district: ref.watch(idDistrictProvider),
                village: ref.watch(idSubdistrictProvider),
                street: _addressCtrl.text,
                zipCode: int.parse(_zipCodeCtrl.text),
              );
              ref
                  .read(editAddressNotifier.notifier)
                  .edit(request)
                  .then((success) {
                if (success) {
                  showSnackbar(context, "success".tr(),
                      type: SnackBarType.success);
                } else {
                  final errMsg = ref.watch(editAddressNotifier).error!;
                  showSnackbar(context, errMsg, type: SnackBarType.error);
                }
              });
            },
            child: isLoading ? const LoadingWidget() : Text("save".tr()),
          ),
        ),
      ],
    );
  }
}

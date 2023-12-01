part of '../../company.dart';

class RegisterCompanyWidget extends ConsumerStatefulWidget {
  const RegisterCompanyWidget({super.key});

  @override
  ConsumerState createState() => _RegisterCompanyWidgetState();
}

class _RegisterCompanyWidgetState extends ConsumerState<RegisterCompanyWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _sizeCtrl;

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _sizeCtrl = TextEditingController(text: "0");
    Future.microtask(() {
      ref.read(typeCompaniesNotifier.notifier).getTypeCompany();
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _sizeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createCompanyNotifier).isLoading;
    final typeCompanies = ref.watch(typeCompaniesNotifier).data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        title: Text("create_company".tr()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "create_your_company".tr(),
                style: const TextStyle(
                  height: 1.2,
                  fontSize: 44,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "description_app".tr(),
                style: const TextStyle(fontSize: 18),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child:
                    Image.asset("assets/images/three_human.png", height: 200),
              ),
            ],
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FieldInput(
                  title: "name".tr(),
                  hintText: "input_company_name".tr(),
                  controllers: _nameCtrl,
                ),
                FieldInput(
                  title: "size_employee".tr(),
                  hintText: "input_size".tr(),
                  controllers: _sizeCtrl,
                  keyboardType: TextInputType.number,
                ),
                DropdownContainer(
                  title: "type_company".tr(),
                  value: ref.watch(idTypeCompanyProvider),
                  items: (typeCompanies ?? [])
                      .map(
                        (type) => DropdownMenuItem(
                          value: type.id,
                          child: Text(type.name ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    ref.read(idTypeCompanyProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _handleRegister,
                  child: isLoading ? const LoadingWidget() : Text("save".tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleRegister() {
    if (formKey.currentState!.validate() &&
        ref.watch(idTypeCompanyProvider) != null) {
      final request = CompanyRequest(
        name: _nameCtrl.text,
        size: int.parse(_sizeCtrl.text),
        typeCompany: ref.watch(idTypeCompanyProvider)!,
      );
      ref
          .read(createCompanyNotifier.notifier)
          .createCompany(request)
          .then((success) {
        if (success) {
          Navigator.of(context).pop();
          showSnackbar(context, "success".tr(), type: SnackBarType.success);
        } else {
          final err = ref.watch(createCompanyNotifier).error;
          showSnackbar(context, err!, type: SnackBarType.error);
        }
      });
    } else {
      showSnackbar(context, "please_select_type_company".tr());
    }
  }
}

part of "../../company.dart";

class DialogEditCompanyWidget extends ConsumerStatefulWidget {
  const DialogEditCompanyWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DialogEditCompanyWidgetState();
}

class _DialogEditCompanyWidgetState
    extends ConsumerState<DialogEditCompanyWidget> {
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    Future.microtask(() {
      final company = ref.watch(detailCompanyNotifier).data;
      _nameCtrl.text = company?.name ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(detailCompanyNotifier).data;
    final image = ref.watch(logoCompanyProvider);
    final cover = ref.watch(coverCompanyProvider);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 720),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text("edit_company".tr()),
                trailing: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.close),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 220,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          if (cover != null)
                            SizedBox(
                                width: double.infinity,
                                height: 220,
                                child: Image.file(cover, fit: BoxFit.cover))
                          else if (company?.cover != null)
                            SizedBox(
                              width: double.infinity,
                              height: 220,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${ConstantUrl.BASEIMGURL}/${company!.cover!}",
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              height: 220,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FilledButton.icon(
                                onPressed: () async {
                                  final newImage = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (newImage != null) {
                                    ref
                                        .read(coverCompanyProvider.notifier)
                                        .state = File(newImage.path);
                                  }
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text("edit cover"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      bottom: 0,
                      child: Builder(builder: (_) {
                        if (image != null) {
                          return CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(image),
                          );
                        } else {
                          if (company?.logo != null) {
                            return CircleAvatarNetwork(company!.logo,
                                size: 150);
                          } else {
                            return const CircleAvatar(
                              radius: 100,
                              child: Icon(Icons.location_city, size: 50),
                            );
                          }
                        }
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  final newImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (newImage != null) {
                    ref.read(logoCompanyProvider.notifier).state =
                        File(newImage.path);
                  }
                },
                child: Text("upload_logo".tr()),
              ),
              const SizedBox(height: 20),
              FieldInput(
                title: "company_name".tr(),
                hintText: "input_name".tr(),
                controllers: _nameCtrl,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref
                          .watch(updateCompanyNotifier.notifier)
                          .updateCompany(
                            company!.id!,
                            name: _nameCtrl.text,
                            image: image,
                            cover: cover,
                          )
                          .then((success) {
                        if (!success) {
                          final err = ref.watch(updateCompanyNotifier).error;
                          showSnackbar(context, err!, type: SnackBarType.error);
                        }
                      });
                    },
                    child: Text("save".tr()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

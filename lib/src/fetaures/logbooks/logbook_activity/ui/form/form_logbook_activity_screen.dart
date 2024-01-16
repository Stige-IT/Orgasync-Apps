part of "../../logbook_activity.dart";

class FormLogBookActivityScreen extends ConsumerStatefulWidget {
  final String? idLogBookEmployee;
  final String? idLogbook;
  const FormLogBookActivityScreen(
      {super.key, this.idLogBookEmployee, this.idLogbook});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormLogBookActivityScreenState();
}

class _FormLogBookActivityScreenState
    extends ConsumerState<FormLogBookActivityScreen> {
  late TextEditingController _descriptinCtrl;

  @override
  void initState() {
    super.initState();
    _descriptinCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptinCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRating = ref.watch(selectedRatingProvider);
    final image = ref.watch(selectedImageLogbookProvider);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 720),
          margin: const EdgeInsets.all(20),
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
                title: const Text(
                  "LogBook Activity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.close),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: [
                  FieldInput(
                    hintText: "input_description".tr(),
                    controllers: _descriptinCtrl,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 255,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text("Rating activity: "),
                    subtitle: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          InkWell(
                            onTap: () {
                              ref.read(selectedRatingProvider.notifier).state =
                                  i + 1;
                            },
                            child: Builder(builder: (_) {
                              if (i >= selectedRating) {
                                return const Icon(Icons.star_border, size: 40);
                              }
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 40,
                              );
                            }),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: context.theme.colorScheme.onBackground
                            .withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: const Icon(Icons.image, size: 50),
                      title: Text(
                        image == null
                            ? "Select Image activity"
                            : image.path.split("\\").last,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          if (image != null) {
                            ref.invalidate(selectedImageLogbookProvider);
                          } else {
                            final newImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 50,
                            );
                            if (newImage != null) {
                              ref
                                  .read(selectedImageLogbookProvider.notifier)
                                  .state = File(newImage.path);
                            }
                          }
                        },
                        icon: image != null
                            ? const Icon(Icons.delete, color: Colors.red)
                            : const Icon(Icons.upload),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (image != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: context.theme.colorScheme.onBackground
                                .withOpacity(0.5),
                          ),
                        ),
                        height: 120,
                        width: 250,
                        child: Image.file(image, fit: BoxFit.cover),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: Navigator.of(context).pop,
                      child: Text("cancel".tr()),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: FilledButton(
                      onPressed: _handleSave,
                      child: Text("save".tr()),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    String? idLogbook;
    final image = ref.watch(selectedImageLogbookProvider);
    if (widget.idLogBookEmployee == null) {
      idLogbook = widget.idLogbook;
    } else {
      idLogbook = ref.watch(detailLogBookNotifier).data!.id!;
    }
    Navigator.of(context).pop();
    ref
        .watch(addLogBookActivityNotifier.notifier)
        .add(
          idLogBookEmployee: widget.idLogBookEmployee,
          idLogBook: idLogbook!,
          description: _descriptinCtrl.text,
          image: image,
          rating: ref.watch(selectedRatingProvider),
        )
        .then((success) {
      if (success) {
        showSnackbar(context, "success".tr());
      } else {
        final err = ref.read(addLogBookActivityNotifier).error;
        showSnackbar(context, err!, type: SnackBarType.error);
      }
    });
  }
}

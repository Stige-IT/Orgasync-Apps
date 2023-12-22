part of "../../../project.dart";

class ListEmployeeProjectScreen extends ConsumerStatefulWidget {
  const ListEmployeeProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListEmployeeProjectScreenState();
}

class _ListEmployeeProjectScreenState
    extends ConsumerState<ListEmployeeProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("employee_project".tr()),
        actions: [
          IconButton(
            onPressed: () => nextPage(context, "/company/project/employee/add"),
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => const Card(
          child: Text("data"),
        ),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: 10,
      ),
    );
  }
}

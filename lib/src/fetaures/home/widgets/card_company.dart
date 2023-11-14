part of "../home.dart";

class CardCompany extends StatelessWidget {
  const CardCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(bottom: 40, top: 10),
          child: Column(
            children: [
              ListTile(
                title: Text("PT. Orgasync Indonesia",
                    style: context.theme.textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w500)),
                subtitle: const Text("July 2021 - Present"),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                trailing: Text(
                  "Intern | Software Engineer",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 10,
          left: 20,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                "https://blog.hubspot.com/hubfs/image8-2.jpg"),
          ),
        ),
      ],
    );
  }
}

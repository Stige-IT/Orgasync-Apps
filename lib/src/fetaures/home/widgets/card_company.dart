part of "../home.dart";

class CardCompany extends StatelessWidget {
  final MyCompany company;

  const CardCompany(this.company, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: context.isDesktop ? context.width * 0.3 : null,
      child: InkWell(
        onTap: () => nextPage(context, "/company/dashboard"),
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.theme.colorScheme.inverseSurface.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(bottom: 40, top: 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(company.company?.name ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: context.theme.textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w500)),
                    subtitle: const Text("July 2021 - Present"),
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    trailing: Text(
                      "${company.typeEmployee?.name} | ${company.position?.name}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color:context.theme.colorScheme.inverseSurface.withOpacity(0.5), width: 2),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(company.company?.logo ??
                      "https://blog.hubspot.com/hubfs/image8-2.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

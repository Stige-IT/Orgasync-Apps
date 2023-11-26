part of "../../user.dart";

class CardCompany extends StatelessWidget {
  const CardCompany({
    super.key,
    required this.company,
    required this.color,
  });

  final Color? color;
  final MyCompany? company;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.colorScheme.surface,
            width: 3,
          ),
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: context.theme.colorScheme.onBackground.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          company?.company?.logo == null
              ? ProfileWithName(company?.company?.name ?? "  ", size: 70)
              : CircleAvatarNetwork(company?.company?.logo, size: 70),
          const SizedBox(height: 10.0),
          Text(
            company?.company?.name ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
          Text(
            company?.position?.name ?? "",
            style: TextStyle(
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${company?.joined?.dateFormat()} - ${company?.end}",
            style: TextStyle(
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

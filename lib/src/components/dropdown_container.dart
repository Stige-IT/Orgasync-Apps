import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DropdownContainer<T> extends StatelessWidget {
  final List<DropdownMenuItem<T?>>? items;
  final void Function(T?)? onChanged;
  final String? title;
  final String? hint;
  final T? value;

  const DropdownContainer({
    super.key,
    required this.items,
    required this.onChanged,
    this.title,
    this.hint,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text("   $title",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline),
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ]),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<T?>(
              value: value,
              hint: Text(hint ?? "choice_your_option".tr()),
              isExpanded: true,
              borderRadius: BorderRadius.circular(15),
              items: items,
              onChanged: onChanged,
            )),
          ),
        ],
      ),
    );
  }
}

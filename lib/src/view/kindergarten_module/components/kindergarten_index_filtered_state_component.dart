import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/provider/kindergarten_provider.dart';

class KindergartenIndexFilteredStateComponent extends StatelessWidget {
  final KindergartenProvider kindergartenProvider;
  const KindergartenIndexFilteredStateComponent(
      {super.key, required this.kindergartenProvider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: kindergartenProvider.getFilteredStates.length,
          itemBuilder: (context, index) {
            return ChoiceChip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              label: Text(kindergartenProvider.getFilteredStates[index].state
                  .toString()),
              selected:
                  kindergartenProvider.getFilteredStates[index].value ?? false,
              onSelected: (selected) {
                kindergartenProvider.toggleStateSelectionsProvider(index);
              },
            );
          }),
    );
  }
}

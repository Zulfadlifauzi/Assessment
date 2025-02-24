import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/provider/kindergarten_provider.dart';

import '../../../../utils/debounce_utils.dart';

class KindergartenIndexSearchFilterComponent extends StatelessWidget {
  final KindergartenProvider kindergartenProvider;
  const KindergartenIndexSearchFilterComponent(
      {super.key, required this.kindergartenProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: kindergartenProvider.getSearchController,
        onChanged: (String values) {
          DebounceUtils.startDebounceTimer(() async {
            await kindergartenProvider.searchKindergartenprovider(values);
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.grey[100],
            filled: true,
            hintText: 'Search name or state of kindergarten...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: kindergartenProvider.getSearchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      kindergartenProvider.clearSearchControllerProvider();
                    },
                  )
                : const SizedBox()),
      ),
    );
  }
}

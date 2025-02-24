import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/provider/kindergarten_provider.dart';
import 'package:provider/provider.dart';

import '../components/kindergarten_index_filtered_state_component.dart';
import '../components/kindergarten_index_list_data_component.dart';
import '../components/kindergarten_index_search_filter_component.dart';

class KindergartenIndexScreen extends StatelessWidget {
  const KindergartenIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KindergartenProvider(),
      child: Scaffold(
        floatingActionButton: Consumer<KindergartenProvider>(
          builder: (context, value, child) {
            return Visibility(
              visible: value.getIsFabVisible,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 1,
                shape: const CircleBorder(),
                onPressed: () => value.getScrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                child: const Icon(
                  Icons.arrow_upward_outlined,
                ),
              ),
            );
          },
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Consumer<KindergartenProvider>(builder: (context, value, _) {
            return Column(
              children: [
                KindergartenIndexSearchFilterComponent(
                  kindergartenProvider: value,
                ),
                KindergartenIndexFilteredStateComponent(
                  kindergartenProvider: value,
                ),
                KindergartenIndexListDataComponent(
                  kindergartenProvider: value,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/provider/kindergarten_provider.dart';

import '../../../../constants/image_constants.dart';
import '../../../widget/container_widget.dart';
import '../../../widget/empty_state_widget.dart';
import '../../../widget/no_more_data_widget.dart';
import '../presentation/kindergarten_show_screen.dart';

class KindergartenIndexListDataComponent extends StatelessWidget {
  final KindergartenProvider kindergartenProvider;
  const KindergartenIndexListDataComponent(
      {super.key, required this.kindergartenProvider});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          await kindergartenProvider.refreshKindergartenListProvider();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount:
              kindergartenProvider.getFilteredKindergartenList.length + 1,
          controller: kindergartenProvider.getScrollController,
          itemBuilder: (context, index) {
            if (index <
                kindergartenProvider.getFilteredKindergartenList.length) {
              return Card(
                child: ListTile(
                  leading: Hero(
                    tag: kindergartenProvider
                        .getFilteredKindergartenList[index].id
                        .toString(),
                    child: CachedNetworkImage(
                      imageUrl: kindergartenProvider
                          .getFilteredKindergartenList[index].imageUrl
                          .toString(),
                      width: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(placeholderImage),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KindergartenShowScreen(
                                kindergartenId: int.parse(kindergartenProvider
                                    .getFilteredKindergartenList[index].id
                                    .toString()),
                              ))),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 19,
                      child: Text(
                        kindergartenProvider
                            .getFilteredKindergartenList[index].id
                            .toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  title: Text(
                    kindergartenProvider.getFilteredKindergartenList[index].name
                        .toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kindergartenProvider
                            .getFilteredKindergartenList[index].description
                            .toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          ContainerWidget(
                            customText: kindergartenProvider
                                .getFilteredKindergartenList[index].state
                                .toString(),
                          ),
                          ContainerWidget(
                            customText: kindergartenProvider
                                .getFilteredKindergartenList[index].city
                                .toString(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (kindergartenProvider.getHasMore) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if (kindergartenProvider.getErrorMessage != '') {
              return Column(
                children: [
                  const Center(
                    child: Text(
                      'Something went wrong, please try again later..',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () async {
                        await kindergartenProvider
                            .refreshKindergartenListProvider();
                      },
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            } else if (kindergartenProvider
                .getFilteredKindergartenList.isEmpty) {
              return const EmptyStateWidget(
                customText: 'No kindergarten found, search other keyword...',
              );
            } else {
              return const NoMoreDataWidget(
                customText: 'No more kindergarten to load',
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/kindergarten_module/presentation/kindergarten_show_screen.dart';
import 'package:kiddocareassessment/src/kindergarten_module/provider/kindergarten_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/image_constants.dart';

class KindergartenIndexScreen extends StatelessWidget {
  const KindergartenIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) =>
              KindergartenProvider()..fetchIndexKindergartenProvider(),
          child: Consumer<KindergartenProvider>(builder: (context, value, _) {
            return Column(
              children: [
                TextField(
                  controller: value.getSearchController,
                  onChanged: (String values) {
                    value.searchKindergarten(values);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: value.getSearchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                value.clearSearchController();
                              },
                            )
                          : const SizedBox()),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () async {
                      value.setCurrentPage = 1;
                      value.setHasMore = true;
                      value.setIndexKindergarten = [];
                      value.setFilteredKindergarten = [];
                      await value.fetchIndexKindergartenProvider();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: value.getFilteredKindergarten.length + 1,
                      controller: value.getScrollController,
                      itemBuilder: (context, index) {
                        if (index < value.getFilteredKindergarten.length) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  value.getFilteredKindergarten[index].id
                                      .toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          KindergartenShowScreen(
                                            kindergartenId: int.parse(value
                                                .getFilteredKindergarten[index]
                                                .id
                                                .toString()),
                                          ))),
                              trailing: CachedNetworkImage(
                                imageUrl: value
                                    .getFilteredKindergarten[index].imageUrl
                                    .toString(),
                                width: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Image.asset(placeholderImage),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(
                                value.getFilteredKindergarten[index].name
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.getFilteredKindergarten[index]
                                        .description
                                        .toString(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 0,
                                            offset: const Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      value.getFilteredKindergarten[index].state
                                          .toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (value.getHasMore) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          );
                        } else if (value.getFilteredKindergarten.isEmpty) {
                          return const Center(
                            child: Text(
                              'No kindergarten found, try searching another keyword',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: value.getHasMore && !value.getIsSearching
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black),
                                  )
                                : const Center(
                                    child: Text(
                                      'No more kindergarten to load',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

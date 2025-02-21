import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/presentation/kindergarten_show_screen.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/provider/kindergarten_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/image_constants.dart';
import '../../../../utils/debounce_utils.dart';

class KindergartenIndexScreen extends StatelessWidget {
  const KindergartenIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => KindergartenProvider(),
          child: Consumer<KindergartenProvider>(builder: (context, value, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: value.getSearchController,
                    onChanged: (String values) async {
                      DebounceUtils.startDebounceTimer(() {
                        value.searchKindergarten(values);
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Search name or state of kindergarten...',
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
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () async {
                      await value.refreshKindergarten();
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
                                  style: const TextStyle(color: Colors.white),
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
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                          return const Text(
                            'No kindergarten found, search other keyword',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'No more kindergarten to load',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
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

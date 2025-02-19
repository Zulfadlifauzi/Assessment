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
            value.getScrollControllerListener();
            return ListView.builder(
              itemCount: value.getIndexKindergarten.length + 1,
              controller: value.scrollController,
              itemBuilder: (context, index) {
                if (index < value.getIndexKindergarten.length) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          value.getIndexKindergarten[index].id.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KindergartenShowScreen(
                                    kindergartenId: int.parse(value
                                        .getIndexKindergarten[index].id
                                        .toString()),
                                  ))),
                      trailing: CachedNetworkImage(
                        imageUrl: value.getIndexKindergarten[index].imageUrl
                            .toString(),
                        width: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Image.asset(placeholderImage),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(
                        value.getIndexKindergarten[index].name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.getIndexKindergarten[index].description
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
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              value.getIndexKindergarten[index].state
                                  .toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (value.getIndexKindergarten.isEmpty) {
                  return value.getHasMore
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'no kindergarten, please come back later.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: value.getHasMore
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'no more kindergarten to load',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                  );
                }
              },
            );
          }),
        ),
      ),
    );
  }
}

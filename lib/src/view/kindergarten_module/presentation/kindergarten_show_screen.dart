import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/model/kindergarten_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/image_constants.dart';
import '../../../widget/container_widget.dart';
import '../provider/kindergarten_provider.dart';

class KindergartenShowScreen extends StatelessWidget {
  final int kindergartenId;
  const KindergartenShowScreen({super.key, required this.kindergartenId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Kindergarten'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => KindergartenProvider()
          ..fetchShowKindergartenProvider(kindergartenId),
        child: Consumer<KindergartenProvider>(
          builder: (context, value, _) {
            if (value.getIsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.getShowKindergarten.toString().isEmpty) {
              return const Center(
                child: Text('Data Kosong'),
              );
            } else {
              final KindergartenDataModel kindergartenShowData =
                  value.getShowKindergarten;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: kindergartenShowData.id.toString(),
                    child: CachedNetworkImage(
                      imageUrl: kindergartenShowData.imageUrl.toString(),
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(placeholderImage),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          kindergartenShowData.name.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          kindergartenShowData.description.toString(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            ContainerWidget(
                              customText: kindergartenShowData.state.toString(),
                            ),
                            ContainerWidget(
                              customText: kindergartenShowData.city.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            ContainerWidget(
                              customText:
                                  kindergartenShowData.contactPerson.toString(),
                            ),
                            ContainerWidget(
                              customText:
                                  kindergartenShowData.contactNo.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

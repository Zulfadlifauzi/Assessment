import 'package:flutter/material.dart';

import '../../../widget/shimmer_widget.dart';

class KindergartenIndexLoadingComponent extends StatelessWidget {
  const KindergartenIndexLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: ShimmerWidget.rectangular(
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        width: 80,
      ),
      trailing: const ShimmerWidget.circular(
        height: 40,
        width: 40,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangular(
            height: 20,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.sizeOf(context).width / 2,
          ),
          const SizedBox(
            height: 10,
          ),
          ShimmerWidget.rectangular(
            height: 20,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.sizeOf(context).width / 5,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 20,
                width: MediaQuery.sizeOf(context).width / 5,
              ),
              const SizedBox(
                width: 10,
              ),
              ShimmerWidget.rectangular(
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 20,
                width: MediaQuery.sizeOf(context).width / 5,
              ),
            ],
          )
        ],
      ),
    ));
  }
}

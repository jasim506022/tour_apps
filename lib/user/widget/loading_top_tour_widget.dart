import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_apps/others/utilies.dart';


class LoadingTopTourWidget extends StatelessWidget {
  const LoadingTopTourWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var utils = Utils(context);
    Color baseShimmerColor = utils.baseShimmerColor;
    Color highlightShimmerColor = utils.highlightShimmerColor;
    Color widgetShimmerColor = utils.widgetShimmerColor;

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 180,
            width: 165,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Shimmer.fromColors(
              baseColor: baseShimmerColor,
              highlightColor: highlightShimmerColor,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: widgetShimmerColor,
                      height: 110,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        color: widgetShimmerColor,
                        height: 16,
                        width: 120,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        color: widgetShimmerColor,
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: widgetShimmerColor,
                    height: 16,
                    width: 165,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        color: widgetShimmerColor,
                        height: 16,
                        width: 120,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        color: widgetShimmerColor,
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

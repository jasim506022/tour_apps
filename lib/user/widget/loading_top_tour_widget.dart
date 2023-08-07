
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';

class LoadingTopTourWidget extends StatelessWidget {
  const LoadingTopTourWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color widgtColors = Colors.grey.shade700;
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
              color: white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade400,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: widgtColors,
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
                        color: widgtColors,
                        height: 16,
                        width: 120,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        color: widgtColors,
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: widgtColors,
                    height: 16,
                    width: 165,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        color: widgtColors,
                        height: 16,
                        width: 120,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        color: widgtColors,
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

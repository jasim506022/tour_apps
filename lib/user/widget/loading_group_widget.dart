import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';

class LoadingGroupdWidget extends StatelessWidget {
  const LoadingGroupdWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color widgtColors = Colors.grey.shade700;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade400,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                          color: widgtColors,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 16,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: widgtColors),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 16,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: widgtColors,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ],
                        ),
                        Container(
                          height: 16,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: widgtColors,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          height: 16,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: widgtColors,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Container(
                            height: 16,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: widgtColors,
                                borderRadius: BorderRadius.circular(15))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

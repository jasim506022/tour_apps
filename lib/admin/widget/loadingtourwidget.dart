import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../const/const.dart';

class LoadingTourWidget extends StatelessWidget {
  const LoadingTourWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color widgtColors = Colors.grey.shade700;
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        return Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: Container(
          height: 110,
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
                    height: 95,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 16,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: widgtColors,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: widgtColors, shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 16,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: widgtColors,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: widgtColors, shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  height: 16,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: widgtColors,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 16,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: widgtColors,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: widgtColors,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    ),
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

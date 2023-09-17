import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/details_provider.dart';


class ChangeImageSildeWidget extends StatelessWidget {
  const ChangeImageSildeWidget({
    super.key,
    this.model,
    required this.value,
  });

  final dynamic model;
  final DetailsProvider value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FancyShimmerImage(
                imageUrl: model.image![value.selectImage],
                height: MediaQuery.of(context).size.height * .5,
                boxFit: BoxFit.fill,
                width: MediaQuery.of(context).size.width),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: SizedBox(
              height: 80,
              width: 250,
              child: ListView.builder(
                itemCount: model.image!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () {
                        Provider.of<DetailsProvider>(context, listen: false)
                            .setImage(imageNumber: index);
                        Provider.of<DetailsProvider>(context, listen: false)
                            .setColor(colorNumber: index);
                      },
                      child: Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(model.image![index]),
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(
                                color: value.getImage == index
                                    ? Colors.red
                                    : Colors.white,
                                width: 5)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

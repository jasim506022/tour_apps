import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/upload_provider.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({
    super.key,
    required this.uploadprovider,
  });
  final UploadProvider uploadprovider;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
      child: GridView.builder(
        itemCount: uploadprovider.getImagesListXFile.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1)),
                  child: Image.file(
                    File(uploadprovider.getImagesListXFile[index].path),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Provider.of<UploadProvider>(context, listen: false)
                      .removieImage(index: index);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
            ],
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}

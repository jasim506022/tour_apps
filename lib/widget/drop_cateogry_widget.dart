import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/droop_category_provider.dart';

import '../model/categoriesmodel.dart';

class DropCategoryWidget extends StatelessWidget {
  const DropCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DropCateogryProvider>(
      builder: (context, cateogryProvider, child) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 55,
          color: Theme.of(context).cardColor,
          child: DropdownButtonFormField<String>(
            dropdownColor: Theme.of(context).cardColor,
            decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondary,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1))),
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
            value: cateogryProvider.getCategory,
            isExpanded: true,
            items: categoryAllString.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (value) {
              Provider.of<DropCateogryProvider>(context, listen: false)
                  .setCategory(cateory: value!);
            },
          ),
        );
      },
    );
  }
}

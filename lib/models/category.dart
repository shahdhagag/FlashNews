import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:newsapp/core/utiles/app_assets.dart';

class CategoryModel {
  String id;
  String title;
  String image;
  VoidCallback onTap;

  CategoryModel(this.onTap, {
    required this.id,
    required this.title,
    required this.image,
  });

//business entertainment general health science sports  technology
  static List<CategoryModel> getCategoriesList() {
    return [
      CategoryModel(
            () {},
        id: "general",
        title: "General",
        image: AppAssets.generalIcon,
      ),
      CategoryModel(
            () {},
        id: "business",
        title: "Business",
        image: AppAssets.businessIcon,
      ),
      CategoryModel(
            () {},
        id: "entertainment",
        title: "Entertainment",
        image: AppAssets.entertainmentIcon,
      ),
      CategoryModel(
            () {},
        id: "health",
        title: "Health",
        image: AppAssets.healthIcon,
      ),
      CategoryModel(
            () {},
        id: "science",
        title: "Science",
        image: AppAssets.scienceIcon,
      ),

      CategoryModel(
            () {},
        id: "technology",
        title: "Technology",
        image: AppAssets.technologyIcon,
      ),
      CategoryModel(
              () {},
          id: "sports",
          title: "Sports",
          image: AppAssets.sportsIcon
      ),

    ];
  }
}
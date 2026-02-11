import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:newsApp/features/home/Category_card.dart';
import 'package:newsApp/models/category.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key, required this.onCategorySelected});
  final Function(CategoryModel) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "home_greeting".tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(16.h),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoryCard(category: CategoryModel.getCategoriesList()[index],
                  index: index,
                  onTap: () { onCategorySelected(CategoryModel.getCategoriesList()[index]); },
                );
              },
              separatorBuilder: (context, index) {
                return Gap(16.h);
              },
              itemCount: CategoryModel.getCategoriesList().length,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsApp/core/cubits/theme_cubit.dart';
import 'package:newsApp/models/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMode();
    bool isImageLeft = index % 2 == 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 195.h,
        decoration: BoxDecoration(
          color: isDark ? Colors.white : const Color(0xff1c1c1c),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: isImageLeft
              ? [_buildImage(left: true), _buildText(context, isDark, isImageLeft)]
              : [_buildText(context, isDark, isImageLeft), _buildImage(left: false)],
        ),
      ),
    );
  }

  /// Image Widget
  Widget _buildImage({required bool left}) {
    return Expanded(
      flex: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(left ? 24 : 0),
          bottomLeft: Radius.circular(left ? 24 : 0),
          topRight: Radius.circular(left ? 100 : 24),
          bottomRight: Radius.circular(left ? 100 : 24),
          // Adding opposing curves for when image is on the right
        //  topLeft: Radius.circular(left ? 24 : 100),
          //bottomLeft: Radius.circular(left ? 24 : 100),
        ),
        child: Image.asset(
          category.image,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ),
    );
  }

  /// Text Content Widget
  Widget _buildText(BuildContext context, bool isDark, bool isImageLeft) {
    // Define the text part
    Widget label = Text(
      "view_all".tr(),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: isDark ? Colors.white : Colors.black,
      ),
    );

    Widget arrowIcon = CircleAvatar(
      radius: 18.r,
      backgroundColor: isDark ? Colors.black : Colors.white,
      child: Icon(
        isImageLeft ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
        size: 14.sp,
        color: isDark ? Colors.white : Colors.black,
      ),
    );

    return Expanded(
      flex: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category.title.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: isDark ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),

          Container
            (
            padding: EdgeInsetsGeometry.directional(bottom: 4,top: 4,end:isImageLeft? 0:8,start: isImageLeft? 8:0),
            decoration: BoxDecoration(
              color: isDark?Color(0xff808080):Color(0xff8f8f8f),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: isImageLeft
                  ? [label, SizedBox(width: 8.w), arrowIcon] //mra label then icon

                  : [arrowIcon, SizedBox(width: 8.w), label], //icon then label
            ),
          ),
        ],
      ),
    );
  }
}
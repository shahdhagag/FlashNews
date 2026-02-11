import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utiles/app_assets.dart';
import '../../../core/utiles/app_colors.dart';

class Language_label extends StatelessWidget {
  const Language_label({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          ImageIcon(
            const AssetImage(AppAssets.languageIcon),
            color: AppColors.whiteColor,
          ),
          Gap(8.w),
          Text(
            'language'.tr(),
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsApp/core/cubits/theme_cubit.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

void showArticleBottomSheet(BuildContext context, Articles article) {
  bool isDark = context.read<ThemeCubit>().isDarkMode();

  // Truncate description manually
  String fullDescription = article.description ?? 'No description available.';
  String displayedDescription = fullDescription;
  int truncateLength = 120;
  String remainingChars = '';

  if (fullDescription.length > truncateLength) {
    remainingChars = fullDescription.substring(truncateLength);
    displayedDescription = fullDescription.substring(0, truncateLength).trim();
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Container(
          height: 361.h,
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(16),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    height: 200.h,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Truncated Description
              Expanded(
                child: Text(
                  remainingChars.isNotEmpty
                      ? '$displayedDescription… [+${remainingChars.length} chars]'
                      : displayedDescription,
                  style: isDark
                      ? Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.black)
                      : Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
              ),

              // Button
              ElevatedButton(
                onPressed: () async {

                  final url = article.url; // Get the article URL
                  if (url != null && await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    // Show error if URL cannot be opened
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cannot open article")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Color(0xFF171717) : Colors.white,
                  foregroundColor: isDark ? Colors.white : Colors.black,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "View Full Article",
                  style: isDark
                      ? Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(color: Colors.white)
                      : Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

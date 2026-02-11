import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsApp/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBottomSheetWidget extends StatelessWidget {
  final Articles article;
  final bool isDark;

  const ArticleBottomSheetWidget({
    super.key,
    required this.article,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        height: 361.h,
        decoration: BoxDecoration(
          color: isDark ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(),
            SizedBox(height: 12.h),
            _buildDescription(context),
            _buildViewButton(context),
          ],
        ),
      ),
    );
  }



  /// Extracted UI Components ////

  Widget _buildImage() {
    return ClipRRect(
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
    );
  }

  Widget _buildDescription(BuildContext context) {
    final String fullDescription = article.description ?? 'No description available.';
    const int truncateLength = 120;

    String displayedText = fullDescription;
    if (fullDescription.length > truncateLength) {
      String displayedDescription = fullDescription.substring(0, truncateLength).trim();
      int remaining = fullDescription.length - truncateLength;
      displayedText = '$displayedDescription… [+$remaining chars]';
    }

    return Expanded(
      child: Text(
        displayedText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Widget _buildViewButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _launchArticleUrl(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF171717) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(
        "View Full Article",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Future<void> _launchArticleUrl(BuildContext context) async {
    final url = article.url;
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot open article")),
        );
      }
    }
  }
}
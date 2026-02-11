
String timeAgoSinceDate(String dateString) {
  if (dateString.isEmpty) return "";

  try {
    DateTime date = DateTime.parse(dateString);
    Duration diff = DateTime.now().difference(date);

    if (diff.inDays >= 365) return "${(diff.inDays / 365).floor()} years ago";
    if (diff.inDays >= 30) return "${(diff.inDays / 30).floor()} months ago";
    if (diff.inDays >= 1) return "${diff.inDays} days ago";
    if (diff.inHours >= 1) return "${diff.inHours} hours ago";
    if (diff.inMinutes >= 1) return "${diff.inMinutes} minutes ago";
    return "just now";
  } catch (e) {
    return "just now";
  }
}



extension DateFormatter on String {
  String toTimeAgo() {
    if (isEmpty) return "";

    try {
      DateTime date = DateTime.parse(this);
      Duration diff = DateTime.now().difference(date);

      if (diff.inDays >= 365) return "${(diff.inDays / 365).floor()} years ago";
      if (diff.inDays >= 30) return "${(diff.inDays / 30).floor()} months ago";
      if (diff.inDays >= 1) return "${diff.inDays} days ago";
      if (diff.inHours >= 1) return "${diff.inHours} hours ago";
      if (diff.inMinutes >= 1) return "${diff.inMinutes} minutes ago";
      return "just now";
    } catch (e) {
      return "just now";
    }
  }
}
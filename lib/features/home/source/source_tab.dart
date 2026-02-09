import 'package:flutter/material.dart';
import 'package:newsapp/models/source_response.dart';

class SourceTab extends StatelessWidget {
  final Sources source;
  final bool isSelected;
  const SourceTab({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      source.name ?? '',

      style: isSelected? Theme.of(context).textTheme.labelMedium: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

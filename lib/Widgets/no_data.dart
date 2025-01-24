import 'package:flutter/material.dart';

class NoDataAvailable extends StatelessWidget {
  final String title;
  final String message;

  const NoDataAvailable({
    Key? key,
    this.title = 'No Data Available',
    this.message = 'We couldn\'t find any data to display',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    // Calculate responsive dimensions
    final containerHeight = size.height * 0.3;
    final containerWidth = size.width > 600 ? 600.0 : size.width * 0.9;
    final iconSize = size.width > 600 ? 60.0 : 45.0;

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: containerWidth,
          minHeight: containerHeight,
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[50]!,
              Colors.grey[100]!,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Icon Stack
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: iconSize,
                  color: Colors.grey[300],
                ),
                Icon(
                  Icons.search,
                  size: iconSize * 0.8,
                  color: Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    letterSpacing: 0.5,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),

            // Message
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

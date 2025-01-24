import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Const/Constant.dart';

class GrageViewCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String phoneNumber;
  final String location;
  final VoidCallback? onCallPressed;
  final VoidCallback? onDirectionsPressed;

  const GrageViewCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.location,
    this.onCallPressed,
    this.onDirectionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with gradient overlay and back button
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 16 / 12,
                    child: Image.network(
                      GrageImageUrl + imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.garage,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Back Button
                Positioned(
                  top: 16,
                  left: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ),
                // Title with gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Contact info with icons
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue[700], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        phoneNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.blue[700], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onCallPressed,
                          icon: const Icon(Icons.phone),
                          label: const Text('Call Now'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Expanded(
                      //   child: ElevatedButton.icon(
                      //     onPressed: onDirectionsPressed,
                      //     icon: const Icon(Icons.directions),
                      //     label: const Text('Get Directions'),
                      //     style: ElevatedButton.styleFrom(
                      //       padding: const EdgeInsets.symmetric(vertical: 12),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

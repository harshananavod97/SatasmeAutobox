import 'package:flutter/material.dart';

import '../../../Utils/Const/Constant.dart';

class InqueryView extends StatelessWidget {
  final String? title;
  final String? additionalInformation;

  final String? phoneNumber;

  final String? image;
  final VoidCallback? onBackPressed;

  const InqueryView({
    super.key,
    this.title,
    this.additionalInformation,
    this.phoneNumber,
    this.image,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and title
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: onBackPressed ?? () => Navigator.pop(context),
                  ),
                  const Text(
                    'Inquery Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    if (image != null)
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Image.network(
                          InquerImageUrl + image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.grey[100],
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      ),

                    // Details section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Text(
                              //   price ?? '',
                              //   style: const TextStyle(
                              //     fontSize: 22,
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.blue,
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Vehicle name
                          _buildInfoRow(
                            icon: Icons.star,
                            label: additionalInformation ?? 'Not specified',
                          ),
                          const SizedBox(height: 12),

                          // Location

                          // Phone
                          _buildInfoRow(
                            icon: Icons.phone,
                            label: phoneNumber ?? 'Not available',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AutoPartAddView extends StatelessWidget {
  final String? title;
  final String? vehicleName;
  final String? district;
  final String? city;
  final String? phoneNumber;
  final String? price;
  final String? image;
  final VoidCallback? onBackPressed;

  const AutoPartAddView({
    super.key,
    this.title,
    this.vehicleName,
    this.district,
    this.city,
    this.phoneNumber,
    this.price,
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
                    'Auto Part Details',
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
                          image!,
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
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'LKR ' + price.toString() ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Vehicle name
                          _buildInfoRow(
                            icon: Icons.directions_car,
                            label: vehicleName ?? 'Not specified',
                          ),
                          const SizedBox(height: 12),

                          // Location
                          _buildInfoRow(
                            icon: Icons.location_on,
                            label: [city, district]
                                .where((e) => e != null)
                                .join(', '),
                          ),
                          const SizedBox(height: 12),

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

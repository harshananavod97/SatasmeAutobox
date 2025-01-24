import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PackageCard extends StatelessWidget {
  final String packageName;
  final String packagePrice;
  final int adsAmount;
  final int topAds;
  final String adsDuration;
  final int imageCount;
  final VoidCallback onActivate;
  final String buttonText;

  const PackageCard({
    Key? key,
    required this.packageName,
    required this.packagePrice,
    required this.adsAmount,
    required this.topAds,
    required this.adsDuration,
    required this.imageCount,
    required this.onActivate,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            packageName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoRow("Package Price", packagePrice),
          _buildInfoRow("Ads Amount", adsAmount.toString()),
          _buildInfoRow("Top Ads", topAds.toString()),
          _buildInfoRow("Ads Duration", adsDuration),
          _buildInfoRow("Image Count", imageCount.toString()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onActivate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

class AdPackageCard extends StatelessWidget {
  final String packageName;
  final String packagePrice;
  final int topAds;
  final VoidCallback onBuyNow;

  const AdPackageCard({
    Key? key,
    required this.packageName,
    required this.packagePrice,
    required this.topAds,
    required this.onBuyNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow("Package Name", packageName),
                const SizedBox(height: 10),
                _buildRow("Package Price", packagePrice),
                const SizedBox(height: 10),
                _buildRow("Top Ads", topAds.toString()),
                const SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

class MyPackageCard extends StatelessWidget {
  final String packageName;

  final int adsAmount;
  final int topAds;
  final String adsDuration;
  final int imageCount;
  final VoidCallback onActivate;
  final String buttonText;

  const MyPackageCard({
    Key? key,
    required this.packageName,
    required this.adsAmount,
    required this.topAds,
    required this.adsDuration,
    required this.imageCount,
    required this.onActivate,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            packageName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoRow("Ads Amount", adsAmount.toString()),
          _buildInfoRow("Top Ads", topAds.toString()),
          _buildInfoRow("Image Count", imageCount.toString()),
          _buildInfoRow("Ads Expire Date", formatDate(adsDuration)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onActivate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    // Parse the string into DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the DateTime object to show only the date (e.g., "2023-06-13")
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}

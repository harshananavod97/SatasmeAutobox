import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Const/Constant.dart';
import 'package:newautobox/Widgets/Image.dart';

class GarageComponent extends StatelessWidget {
  final String name;
  final String city;
  final String number;
  final String image;

  const GarageComponent({
    Key? key,
    required this.name,
    required this.city,
    required this.number,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = MediaQuery.of(context).orientation;
        final size = MediaQuery.of(context).size;

        // Adjust dimensions based on orientation
        final containerWidth = orientation == Orientation.portrait
            ? size.width * 0.85
            : size.width * 0.45;

        final imageHeight = orientation == Orientation.portrait
            ? size.height * 0.25
            : size.height * 0.35;

        return Container(
          width: containerWidth,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Container
              Container(
                height: imageHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: QImage(
                    imageUrl: GrageImageUrl + image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              // Content Container
              Padding(
                padding: EdgeInsets.all(
                    orientation == Orientation.portrait ? 16.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garage Name
                    Text(
                      name,
                      style: TextStyle(
                        color: const Color(0xFF2D3142),
                        fontSize: orientation == Orientation.portrait ? 20 : 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(
                        height: orientation == Orientation.portrait ? 16 : 20),

                    // Location and Contact Info
                    orientation == Orientation.portrait
                        ? _buildPortraitInfoSection()
                        : _buildLandscapeInfoSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPortraitInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Location
        Expanded(
          child: Row(
            children: [
              _buildIconContainer(
                Icons.location_on,
                const Color(0xFF4A90E2),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  city,
                  style: const TextStyle(
                    color: Color(0xFF4A5567),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Phone Number
        Expanded(
          child: Row(
            children: [
              _buildIconContainer(
                Icons.call,
                const Color(0xFF2ECC71),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFF4A5567),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location
        Row(
          children: [
            _buildIconContainer(
              Icons.location_on,
              const Color(0xFF4A90E2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                city,
                style: const TextStyle(
                  color: Color(0xFF4A5567),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Phone Number
        Row(
          children: [
            _buildIconContainer(
              Icons.call,
              const Color(0xFF2ECC71),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                number,
                style: const TextStyle(
                  color: Color(0xFF4A5567),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconContainer(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Const/Constant.dart';

class MyInqueryCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;

  final String phoneNumber;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MyInqueryCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.description,
    required this.phoneNumber,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        height: 120, // Reduced fixed height
        child: Row(
          children: [
            // Image Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 120, // Square image container
                height: 120,
                child: imageUrl != null
                    ? Image.network(
                        InquerImageUrl + imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Price
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(Icons.call,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                phoneNumber,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Menu Button
                    Positioned(
                      top: 0,
                      right: 0,
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.more_vert, size: 20),
                        onSelected: (String choice) {
                          if (choice == 'Edit' && onEdit != null) {
                            onEdit!();
                          } else if (choice == 'Delete' && onDelete != null) {
                            onDelete!();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          // const PopupMenuItem<String>(
                          //   value: 'Edit',
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.edit, color: Colors.blue, size: 18),
                          //       SizedBox(width: 8),
                          //       Text('Edit', style: TextStyle(fontSize: 14)),
                          //     ],
                          //   ),
                          // ),
                          const PopupMenuItem<String>(
                            value: 'Delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(fontSize: 14)),
                              ],
                            ),
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
}

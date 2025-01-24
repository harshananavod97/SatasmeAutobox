import 'package:flutter/material.dart';
import 'package:newautobox/Widgets/DrawerWideget.dart';

class ImageSourceDialog extends StatefulWidget {
  final Function()? onGallery;
  final Function()? onCamera;

  ImageSourceDialog({this.onGallery, this.onCamera});

  @override
  State<ImageSourceDialog> createState() => _ImageSourceDialogState();
}

class _ImageSourceDialogState extends State<ImageSourceDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Source',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel_outlined)),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: inkWellWidget(
                  onTap: widget.onGallery ?? () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/ic_gallery.png",
                            height: 30, width: 30, fit: BoxFit.cover),
                        SizedBox(height: 16),
                        Text('Gallery',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: inkWellWidget(
                  onTap: widget.onCamera ?? () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/ic_camera.png',
                            height: 30, width: 30, fit: BoxFit.cover),
                        SizedBox(height: 16),
                        Text('Camera',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

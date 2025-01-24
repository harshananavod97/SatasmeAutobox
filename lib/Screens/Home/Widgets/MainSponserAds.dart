import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newautobox/Model/AllAdsModel.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Screens/Home/Widgets/NoAds_Component.dart';
import 'package:newautobox/Utils/Const/Constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainSponserAds extends StatefulWidget {
  @override
  _MainSponserAdsState createState() => _MainSponserAdsState();
}

class _MainSponserAdsState extends State<MainSponserAds> {
  int _current = 0; // Current index for the active dot

  @override
  Widget build(BuildContext context) {
    final adsController = Provider.of<AllAdsController>(context);

    return StreamBuilder<AllAddModel?>(
      stream: adsController.adsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            ),
          );
        } else if (snapshot.hasError) {
          return NoAdsModernWidget();
        } else if (!snapshot.hasData || snapshot.data!.tad.isEmpty) {
          return NoAdsModernWidget();
        }

        final data = snapshot.data!;

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: data.tad.length,
              itemBuilder: (context, index, realIndex) {
                final item = data.tad[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: NetworkImage(AdsImageUrl + item.name),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        color: Colors.yellow,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          item.adTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Text(
                        item.adDistrict,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.red,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Dots Positioned at the Bottom Center of the Image
                    Positioned(
                      bottom:
                          10, // Adjust this value to control vertical position
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: data.tad.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              _current = entry.key;
                            }),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(
                                    _current == entry.key
                                        ? 0.9
                                        : 0.4), // White dots with opacity
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 2.0,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index; // Update the active dot
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

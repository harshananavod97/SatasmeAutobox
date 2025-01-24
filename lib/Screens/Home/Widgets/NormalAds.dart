import 'package:flutter/material.dart';
import 'package:newautobox/Model/AllAdsModel.dart';
import 'package:newautobox/Provider/allAdsController.dart';
import 'package:newautobox/Screens/Home/Widgets/AutoPartsViewScreen.dart';
import 'package:newautobox/Screens/Home/Widgets/NoAds_Component.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/Constant.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';
import 'package:newautobox/Widgets/DrawerWideget.dart';
import 'package:newautobox/Widgets/Image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NormalAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adsController = Provider.of<AllAdsController>(context);
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    // Adjust dimensions based on orientation
    final containerHeight = orientation == Orientation.portrait
        ? size.height * 0.30
        : size.height * 0.7;

    final cardWidth = orientation == Orientation.portrait
        ? size.width * 0.7
        : size.width * 0.4;

    final imageHeight = orientation == Orientation.portrait
        ? containerHeight * 0.5
        : containerHeight * 0.6;

    return LayoutBuilder(
      builder: (context, constraints) {
        return StreamBuilder<AllAddModel?>(
          stream: adsController.adsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerLoader(
                context,
                containerHeight,
                cardWidth,
                imageHeight,
              );
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.tad.isEmpty) {
              return NoAdsModernWidget();
            }

            final data = snapshot.data!;
            return SizedBox(
              height: containerHeight,
              child: ListView.builder(
                itemCount: data.ads.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = data.ads.data[index];
                  return _buildAdCard(
                    context,
                    item,
                    cardWidth,
                    imageHeight,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildShimmerLoader(
    BuildContext context,
    double containerHeight,
    double cardWidth,
    double imageHeight,
  ) {
    return SizedBox(
      height: containerHeight,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: cardWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Container(
                        height: imageHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            height: 20,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 60,
                            height: 20,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdCard(
    BuildContext context,
    dynamic item,
    double cardWidth,
    double imageHeight,
  ) {
    return inkWellWidget(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AutoPartAddView(
              city: item.adCity,
              district: item.adDistrict,
              phoneNumber: item.adNumber.toString(),
              price: item.adPrice.toString(),
              title: item.adTitle,
              vehicleName: item.vtName,
              image:
                  'https://jobhelp.test.satasmewebdev.online/assets/myCustomThings/vehicleTypes/${item.name}',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: imageHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: QImage(
                      imageUrl: AdsImageUrl + item.name,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.adTitle,
                        style: const TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeights.medium,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'LKR ${item.adPrice.toString()}',
                            style: const TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontSize: 16,
                              fontWeight: FontWeights.semiBold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place,
                                size: 16,
                                color: AppColors.PRIMARY_COLOR.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.adCity,
                                style: TextStyle(
                                  color:
                                      AppColors.PRIMARY_COLOR.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeights.regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/provider/shop_info_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/view/base/custom_image.dart';

class ShopBannerWidget extends StatelessWidget {
  final ShopProvider? resProvider;
  const ShopBannerWidget({Key? key, this.resProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width/3,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
            topRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
        child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).
        baseUrls!.shopImageUrl}/banner/${resProvider!.shopModel?.banner}'),
      ),
    );
  }
}

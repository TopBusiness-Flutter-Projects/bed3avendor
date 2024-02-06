import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/provider/theme_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/base/custom_dialog.dart';
import 'package:bed3avendor/view/screens/langulage/change_language.dart';
import 'package:bed3avendor/view/screens/settings/widget/choose_shipping_dialog.dart';

import '../../../provider/search_product_provider.dart';
import '../../../utill/color_resources.dart';
import '../../base/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Provider.of<SearchProvider>(context, listen: false).getSellerLimit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('settings', context),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          TitleButton(
            icon: Images.language,
            title: getTranslated('choose_language', context),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ChooseLanguageScreen())),
          ),
          Provider.of<SplashProvider>(context, listen: false)
                      .configModel!
                      .shippingMethod ==
                  'sellerwise_shipping'
              ? TitleButton(
                  icon: Images.ship,
                  title: '${getTranslated('shipping_setting', context)}',
                  onTap: () =>
                      showAnimatedDialog(context, ChooseShippingDialog()),
                )
              : SizedBox(),
          TitleButton(
              icon: 'assets/image/product_icon_pp.png',
              title: 'الحد الادني و السعر للتاجر',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Consumer<SearchProvider>(
                      builder: (context, order, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorResources.getHomeBg(context),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: Theme.of(context).primaryColor,
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Text(getTranslated('price', context)!,
                                    style: titilliumRegular.copyWith(
                                        color: ColorResources.getTextColor(
                                            context))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 45),
                                child: Row(
                                  children: [
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          order.changeLimitPrice(isAdd: true);
                                          // if (order.maxPriceOfSeller >= 1) {
                                          //   order.maxPriceOfSeller += 1;
                                          // } else {
                                          //   order.maxPriceOfSeller = 1;
                                          // }
                                          setState(() {});
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                      ),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Dimensions
                                                  .PADDING_SIZE_LARGE)),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.06)),
                                    ),
                                    Spacer(),
                                    Text(
                                        "${order.maxPriceOfSeller.toString()} ج.م",
                                        style: titilliumRegular.copyWith(
                                            color: ColorResources.getTextColor(
                                                context))),
                                    Spacer(),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          order.changeLimitPrice(isAdd: false);

                                          // if (order.maxPriceOfSeller > 1) {
                                          //   order.maxPriceOfSeller =
                                          //       order.maxPriceOfSeller - 1;
                                          // } else {
                                          //   order.maxPriceOfSeller = 1;
                                          // }
                                          setState(() {});
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        )),
                                      ),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Dimensions
                                                  .PADDING_SIZE_LARGE)),
                                          color: Colors.red.withOpacity(.06)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Text("الحد الاقصى",
                                    style: titilliumRegular.copyWith(
                                        color: ColorResources.getTextColor(
                                            context))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 45),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        order.changeLimitQty(isAdd: true);
                                        // if (order.maxQtyOfSeller > 1) {
                                        //   order.maxQtyOfSeller =
                                        //       order.maxQtyOfSeller + 1;
                                        // } else {
                                        //   order.maxQtyOfSeller = 1;
                                        // }
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimensions
                                                    .PADDING_SIZE_LARGE)),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.06)),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(order.maxQtyOfSeller.toString(),
                                        style: titilliumRegular.copyWith(
                                            color: ColorResources.getTextColor(
                                                context))),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        order.changeLimitQty(isAdd: false);
                                        // if (order.maxQtyOfSeller > 1) {
                                        //   order.maxQtyOfSeller =
                                        //       order.maxQtyOfSeller - 1;
                                        // } else {
                                        //   order.maxQtyOfSeller = 1;
                                        // }

                                        print(order.maxQtyOfSeller.toString());
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        )),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimensions
                                                    .PADDING_SIZE_LARGE)),
                                            color: Colors.red.withOpacity(.06)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: CustomButton(
                                  btnTxt: 'حفظ التعديلات',
                                  onTap: () {
                                    order.addSellerLimit(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String icon;
  final String? title;
  final Function onTap;
  TitleButton({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  color: Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme
                      ? Theme.of(context).primaryColor.withOpacity(0)
                      : Colors.grey[
                          Provider.of<ThemeProvider>(context).darkTheme
                              ? 800
                              : 200]!,
                  spreadRadius: 0.5,
                  blurRadius: 0.3)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT,
                horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Row(
              children: [
                Container(
                    width: Dimensions.ICON_SIZE_LARGE,
                    height: Dimensions.ICON_SIZE_LARGE,
                    child: Image.asset(icon)),
                SizedBox(
                  width: Dimensions.PADDING_SIZE_SMALL,
                ),
                Text(title!,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                  size: Dimensions.ICON_SIZE_SMALL,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

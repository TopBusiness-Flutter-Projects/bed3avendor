import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/auth_provider.dart';
import 'package:bed3avendor/provider/business_provider.dart';
import 'package:bed3avendor/provider/localization_provider.dart';
import 'package:bed3avendor/provider/shipping_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/base/custom_dialog.dart';
import 'package:bed3avendor/view/base/no_data_screen.dart';
import 'package:bed3avendor/view/screens/settings/order_wise_shipping_add_screen.dart';
import 'package:bed3avendor/view/screens/settings/widget/order_wise_shipping_card.dart';
import 'package:bed3avendor/view/screens/shipping/widget/drop_down_for_shipping_type.dart';
import 'package:bed3avendor/view/screens/shop/widget/animated_floating_button.dart';

class OrderWiseShippingScreen extends StatefulWidget {
  @override
  State<OrderWiseShippingScreen> createState() =>
      _OrderWiseShippingScreenState();
}

class _OrderWiseShippingScreenState extends State<OrderWiseShippingScreen> {
  @override
  void initState() {
    Provider.of<ShippingProvider>(context, listen: false).iniType('order_wise');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BusinessProvider>(context, listen: false)
        .getBusinessList(context);
    Provider.of<ShippingProvider>(context, listen: false).getShippingList(
        context,
        Provider.of<AuthProvider>(context, listen: false).getUserToken());
    ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      appBar: CustomAppBar(
          title: getTranslated('business_settings', context),
          isBackButtonExist: true),
      body: Stack(
        children: [
          Column(
            children: [
              DropDownForShippingTypeWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_SMALL,
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.125),
                      borderRadius: BorderRadius.circular(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#    ${getTranslated('details', context)}',
                        style: robotoMedium,
                      ),
                      Text(
                        getTranslated('action', context)!,
                        style: robotoMedium,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Consumer<ShippingProvider>(
                      builder: (context, shipProv, child) {
                    return shipProv.shippingList != null
                        ? shipProv.shippingList!.length > 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_SMALL),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    itemCount: shipProv.shippingList!.length,
                                    itemBuilder: (context, index) {
                                      return OrderWiseShippingCard(
                                        shipProv: shipProv,
                                        shippingModel:
                                            shipProv.shippingList![index],
                                        index: index,
                                      );
                                    }),
                              )
                            : NoDataScreen()
                        : Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor));
                  }),
                ),
              ),
            ],
          ),
          Positioned(
            child: Align(
              alignment:
                  Provider.of<LocalizationProvider>(context, listen: false)
                          .isLtr
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
                child: ScrollingFabAnimated(
                  width: 150,
                  color: Theme.of(context).cardColor,
                  icon: SizedBox(
                      width: Dimensions.ICON_SIZE_EXTRA_LARGE,
                      child: Image.asset(Images.add_icon)),
                  text: Text(
                    getTranslated('add_new', context)!,
                    style: robotoRegular.copyWith(),
                  ),
                  onPress: () =>
                      showAnimatedDialog(context, OrderWiseShippingAddScreen()),
                  animateIcon: true,
                  inverted: false,
                  scrollController: scrollController,
                  radius: 100.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

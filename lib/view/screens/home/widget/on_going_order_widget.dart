import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/screens/home/widget/order_type_button_head.dart';

class OngoingOrderWidget extends StatelessWidget {
  final Function? callback;
  const OngoingOrderWidget({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, order, child) {
      return Container(
        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: ColorResources.getPrimary(context).withOpacity(.05),
                spreadRadius: -3,
                blurRadius: 12,
                offset: Offset.fromDirection(0, 6))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_MEDIUM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: Dimensions.ICON_SIZE_LARGE,
                      height: Dimensions.ICON_SIZE_LARGE,
                      padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Image.asset(Images.monthly_earning)),
                  SizedBox(
                    width: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  Text(
                    getTranslated('business_analytics', context)!,
                    style: robotoBold.copyWith(
                        color: ColorResources.getTextColor(context),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),

                  // Expanded(child: SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE,)),
                  // Container(
                  //   height: 50,width: 120,
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).cardColor,
                  //     border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                  //     borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //
                  //   ),
                  //   child: DropdownButton<String>(
                  //     value: order.analyticsIndex == 0 ? 'overall' : order.analyticsIndex == 1 ?  'today' : 'this_month',
                  //     items: <String>['overall', 'today', 'this_month' ].map((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(getTranslated(value, context)!, style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                  //       );
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       order.setAnalyticsFilterName(context,value, true);
                  //      order.setAnalyticsFilterType(value == 'overall' ? 0 : value == 'today'? 1:2, true);
                  //
                  //     },
                  //     isExpanded: true,
                  //     underline: SizedBox(),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SEVEN),
              child: Text(
                getTranslated('on_going_orders', context)!,
                style:
                    robotoBold.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),

            order.orderModel != null
                ? Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Dimensions.PADDING_SIZE_SMALL,
                                  0,
                                  Dimensions.PADDING_SIZE_SMALL,
                                  Dimensions.FONT_SIZE_SMALL),
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: (1 / .65),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: [
                                  OrderTypeButtonHead(
                                    color: ColorResources.mainCardOneColor(
                                        context),
                                    text: getTranslated('orders', context),
                                    index: 1,
                                    subText: getTranslated('pending', context),
                                    numberOfOrder:
                                        orderProvider.homeScreenModel?.pending,
                                    callback: callback,
                                  ),
                                  OrderTypeButtonHead(
                                    color: ColorResources.mainCardTwoColor(
                                        context),
                                    text: getTranslated('processing', context),
                                    index: 2,
                                    numberOfOrder: orderProvider
                                        .homeScreenModel?.processing,
                                    callback: callback,
                                    subText: '',
                                  ),
                                  OrderTypeButtonHead(
                                    color: ColorResources.mainCardThreeColor(
                                        context),
                                    text: getTranslated('in_way', context),
                                    index: 7,
                                    subText: '',
                                    numberOfOrder: orderProvider
                                        .homeScreenModel?.confirmed,
                                    callback: callback,
                                  ),
                                  OrderTypeButtonHead(
                                    color: ColorResources.mainCardFourColor(
                                        context),
                                    text: getTranslated('delivered', context),
                                    index: 8,
                                    subText: '',
                                    numberOfOrder: orderProvider
                                        .homeScreenModel?.delivered,
                                    callback: callback,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.PADDING_SIZE),
                                    ),
                                    color: ColorResources.YELLOW),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Row(
                                    children: [
                                      Text(
                                        'اجمالى الفواتير',
                                        style: robotoMedium.copyWith(
                                            color: ColorResources.getWhite(
                                                context),
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${orderProvider.homeScreenModel?.totalPrice} ج.م',
                                        style: robotoMedium.copyWith(
                                            color: ColorResources.getWhite(
                                                context),
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                : SizedBox(
                    height: 150,
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor)))),
            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ],
        ),
      );
    });
  }
}

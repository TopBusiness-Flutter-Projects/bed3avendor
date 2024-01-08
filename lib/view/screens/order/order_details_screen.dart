import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/data/model/response/order_model.dart';
import 'package:bed3avendor/helper/price_converter.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/delivery_man_provider.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_button.dart';
import 'package:bed3avendor/view/base/no_data_screen.dart';

import 'package:bed3avendor/view/screens/order/widget/order_product_list_item.dart';
import 'package:bed3avendor/view/screens/order/widget/order_setup.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order? orderModel;
  final int? orderId;
  final String? orderType;
  final String? shippingType;
  final double? extraDiscount;
  final String? extraDiscountType;
  OrderDetailsScreen(
      {this.orderModel,
      required this.orderId,
      required this.orderType,
      this.shippingType,
      this.extraDiscount,
      this.extraDiscountType});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _loadData(BuildContext context, String? type) async {
    if (widget.orderModel == null) {
      await Provider.of<SplashProvider>(context, listen: false)
          .initConfig(context);
    }
    Provider.of<OrderProvider>(context, listen: false)
        .getOrderDetails(widget.orderId.toString(), context);
    Provider.of<OrderProvider>(context, listen: false).initOrderStatusList(
        context,
        Provider.of<SplashProvider>(context, listen: false)
                    .configModel!
                    .shippingMethod ==
                'inhouse_shipping'
            ? 'inhouse_shipping'
            : "seller_wise");
    Provider.of<DeliveryManProvider>(context, listen: false)
        .getDeliveryManList(widget.orderModel, context);
  }

  bool _onlyDigital = true;

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false)
        .setPaymentStatus(widget.orderModel!.paymentStatus);
    Provider.of<OrderProvider>(context, listen: false)
        .updateStatus(widget.orderModel!.orderStatus, notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    _loadData(context, widget.shippingType);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Row(
          children: [
            Spacer(),
            Text(getTranslated("order_details", context)!,
                style: titilliumRegular.copyWith(color: Colors.black)),
            Spacer(),
            Icon(Icons.save, color: ColorResources.getBlue(context)),
            Icon(Icons.print, color: ColorResources.getBlue(context))
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData(context, widget.shippingType);
          // return true;
        },
        child: Consumer<OrderProvider>(builder: (context, order, child) {
          double _itemsPrice = 0;
          double _discount = 0;
          double? eeDiscount = 0;
          double _coupon = widget.orderModel!.discountAmount!;
          double _tax = 0;
          double _shipping = widget.orderModel!.shippingCost!;
          if (order.orderDetails != null) {
            order.orderDetails!.forEach((orderDetails) {
              if (orderDetails.productDetails?.productType == "physical") {
                _onlyDigital = false;
              }
              _itemsPrice =
                  _itemsPrice + (orderDetails.price! * orderDetails.qty!);
              _discount = _discount + orderDetails.discount!;

              _tax = _tax + orderDetails.tax!;
            });
          }
          double _subTotal = _itemsPrice + _tax - _discount;

          if (widget.orderType == 'POS') {
            if (widget.extraDiscountType == 'percent') {
              eeDiscount = _itemsPrice * (widget.extraDiscount! / 100);
            } else {
              eeDiscount = widget.extraDiscount;
            }
          }
          double _totalPrice = _subTotal + _shipping - _coupon - eeDiscount!;

          return order.orderDetails != null
              ? order.orderDetails!.length > 0
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              //      OrderTopSection(orderModel: widget.orderModel, order: order, orderType: widget.orderType, onlyDigital: _onlyDigital,),

                              //    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              // widget.orderType == 'POS'? SizedBox():
                              // ShippingAndBillingWidget(orderModel: widget.orderModel, onlyDigital: _onlyDigital),
                              //

                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(getTranslated('order_summery', context)!,
                                          //     style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                          //       color: ColorResources.titleColor(context),) ),
                                          // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                                          ListView.builder(
                                            padding: EdgeInsets.all(0),
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                order.orderDetails!.length,
                                            itemBuilder: (context, index) {
                                              return OrderedProductListItem(
                                                orderDetailsModel:
                                                    order.orderDetails![index],
                                                paymentStatus:
                                                    order.paymentStatus,
                                                orderId: widget.orderId,
                                                index: index,
                                                length:
                                                    order.orderDetails!.length,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    // widget.orderModel!.orderNote != null?
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     color: Theme.of(context).cardColor,
                                    //       boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25),spreadRadius: .11,blurRadius: .11, offset: Offset(0,2))],
                                    //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                                    //         bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                                    //   ),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Theme.of(context).hintColor.withOpacity(.07),
                                    //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                                    //           bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                                    //
                                    //     ),
                                    //     padding: EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT,
                                    //          Dimensions.PADDING_SIZE_DEFAULT),
                                    //
                                    //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                    //       Row(
                                    //         children: [
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                                    //             child: Image.asset(Images.order_note,color: ColorResources.getTextColor(context), width: Dimensions.ICON_SIZE_SMALL ),
                                    //           ),
                                    //           Text(getTranslated('order_note', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //             color: ColorResources.titleColor(context),)),
                                    //         ],
                                    //       ),
                                    //       SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    //
                                    //       Text('${widget.orderModel!.orderNote != null? widget.orderModel!.orderNote ?? '': ""}',
                                    //           style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
                                    //     ],),
                                    //   ),
                                    // ):SizedBox(),
                                  ]),

                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                                child: Column(
                                  children: [
                                    // // Total
                                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('sub_total', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //
                                    //
                                    //   Text(PriceConverter.convertPrice(context, _itemsPrice),
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),]),
                                    // SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    //

                                    //
                                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('tax', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //
                                    //
                                    //   Text('+ ${PriceConverter.convertPrice(context, _tax)}',
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),]),
                                    // SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    //
                                    //
                                    //
                                    //
                                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('discount', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //
                                    //
                                    //   Text('- ${PriceConverter.convertPrice(context, _discount)}',
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),]),
                                    // SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    //
                                    //
                                    //
                                    // widget.orderType == "POS"?
                                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('extra_discount', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //   Text('- ${PriceConverter.convertPrice(context, eeDiscount)}',
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    // ]):SizedBox(),
                                    // SizedBox(height:  widget.orderType == "POS"? Dimensions.PADDING_SIZE_SMALL: 0),

                                    //
                                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('coupon_discount', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //   Text('- ${PriceConverter.convertPrice(context, _coupon)}',
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),]),
                                    // SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                                    // if(!_onlyDigital)Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //   Text(getTranslated('shipping_fee', context)!,
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),
                                    //   Text('+ ${PriceConverter.convertPrice(context, _shipping)}',
                                    //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //           color: ColorResources.titleColor(context))),]),
                                    //
                                    //   SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                    //   CustomDivider(),
                                    //   SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

// Expanded(child: Container()),
                                  ],
                                ),
                              ),

                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                              // widget.orderModel!.customer != null?
                              // CustomerContactWidget(orderModel: widget.orderModel):SizedBox(),

                              // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              //
                              //
                              // widget.orderModel!.deliveryMan != null?
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                              //   child: DeliveryManContactInformation(orderModel: widget.orderModel, orderType: widget.orderType, onlyDigital: _onlyDigital),
                              // ):SizedBox(),
                              //
                              // widget.orderModel!.thirdPartyServiceName != null?
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                              //   child: ThirdPartyDeliveryInfo(orderModel: widget.orderModel),
                              // ):SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getTranslated('total_amount', context)!,
                                    style: titilliumSemiBold.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_LARGE,
                                        color: Colors.black)),
                                Text(
                                  PriceConverter.convertPrice(
                                      context, _totalPrice),
                                  style: titilliumSemiBold.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_LARGE,
                                      color: Colors.black),
                                ),
                              ]),
                        ),
                      ],
                    )
                  : NoDataScreen()
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)));
        }),
      ),
      bottomNavigationBar: widget.orderType == 'POS'
          ? SizedBox.shrink()
          : Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: ThemeShadow.getShadow(context)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomButton(
                        borderRadius: Dimensions.PADDING_SIZE_MEDIUM,
                        btnTxt: getTranslated('confirm', context),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OrderSetup(
                                      orderType: widget.orderType,
                                      orderModel: widget.orderModel,
                                      onlyDigital: _onlyDigital)));
                        },
                      )),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: ThemeShadow.getShadow(context)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomButton(
                        backgroundColor: Theme.of(context).errorColor,
                        borderRadius: Dimensions.PADDING_SIZE_MEDIUM,
                        btnTxt: getTranslated('cancel', context),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OrderSetup(
                                      orderType: widget.orderType,
                                      orderModel: widget.orderModel,
                                      onlyDigital: _onlyDigital)));
                        },
                      )),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/data/model/response/order_model.dart';
import 'package:bed3avendor/helper/date_converter.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/theme_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/screens/order/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final Order orderModel;
  final int? index;
  OrderWidget({required this.orderModel, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(
                          orderModel: orderModel,
                          orderId: orderModel.id,
                          orderType: orderModel.orderType,
                          extraDiscount: orderModel.extraDiscount,
                          extraDiscountType: orderModel.extraDiscountType,
                        ))),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                  boxShadow: [
                    BoxShadow(
                        color: Provider.of<ThemeProvider>(context,
                                    listen: false)
                                .darkTheme
                            ? Theme.of(context).primaryColor.withOpacity(0)
                            : Theme.of(context).primaryColor.withOpacity(.09),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(1, 2))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                            topRight: Radius.circular(
                                Dimensions.PADDING_SIZE_SMALL))),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.05),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                  child: Center(
                                      child: Text(
                                          '${orderModel.customer?.fName ?? ''} ${orderModel.customer?.lName ?? ''}',
                                          style: robotoMedium.copyWith(
                                              overflow: TextOverflow.fade,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_LARGE))))),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            // decoration: BoxDecoration(
                            //     color: Theme.of(context).primaryColor.withOpacity(.05),
                            //     borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                            // ),
                            child: Row(
                              children: [
                                Text(
                                  '${orderModel.id} ',
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'تفاصيل الطلب',
                                style:
                                    robotoMedium.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                            bottomRight: Radius.circular(
                                Dimensions.PADDING_SIZE_SMALL))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          0,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    orderModel.createdAt != null
                                        ? Text(
                                            DateConverter
                                                .localDateToIsoStringAMPM(
                                                    DateTime.parse(
                                                        orderModel.createdAt!)),
                                            maxLines: 1,
                                            style: robotoRegular.copyWith(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT))
                                        : SizedBox(),
                                    Text(
                                        'المنطقة : ${orderModel.customer?.city ?? ''}',
                                        maxLines: 1,
                                        style: robotoRegular.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(getTranslated('discount', context)!,
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      Text(
                                          orderModel.discountAmount.toString() +
                                              " " +
                                              'ج.م ',
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                      "الاصناف : " + '${orderModel.qty ?? ''} ',
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).hintColor)),
                                  Text('${orderModel.orderAmount} ج.م',
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).hintColor)),
                                ],
                              ),
                            ],
                          ),

                          // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: Dimensions.ICON_SIZE_SMALL,
                                width: Dimensions.ICON_SIZE_SMALL,
                                child: Image.asset(orderModel.orderStatus ==
                                        'pending'
                                    ? Images.order_pending_icon
                                    : orderModel.orderStatus ==
                                            'out_for_delivery'
                                        ? Images.out_icon
                                        : orderModel.orderStatus == 'returned'
                                            ? Images.return_icon
                                            : orderModel.orderStatus ==
                                                    'delivered'
                                                ? Images.delivered_icon
                                                : Images.confirm_purchase),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    getTranslated(
                                            orderModel.orderStatus, context) ??
                                        '',
                                    style: robotoRegular.copyWith(
                                        color: ColorResources.getPrimary(
                                            context))),
                              ),
                              Spacer(),
                              orderModel.orderStatus == 'canceled'
                                  ? IconButton(
                                      onPressed: () {
                                        orderModel.orderReason == null
                                            ? Fluttertoast.showToast(
                                                msg: 'لايوجد سبب للرفض')
                                            : showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20.0)),
                                                ),
                                                backgroundColor: Colors
                                                    .blueAccent, // Change the background color
                                                builder:
                                                    (BuildContext context) {
                                                  return CustomBottomSheet(
                                                      cancelReason: orderModel
                                                          .orderReason);
                                                },
                                              );
                                      },
                                      icon: Image.asset(
                                          'assets/image/cancel_order.png',
                                          width: 25,
                                          height: 25),
                                    )
                                  : Container()
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //     SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  String? cancelReason;
  CustomBottomSheet({required this.cancelReason});
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(22),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Container(
              width: double.infinity,
              child: Text('سبب للرفض',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))),
          subtitle: Text(widget.cancelReason ?? '',
              style: TextStyle(color: Colors.white)),
        ));
  }
}

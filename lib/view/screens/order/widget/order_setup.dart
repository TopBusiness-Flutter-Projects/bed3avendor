import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/data/model/response/order_model.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/base/custom_drop_down_item.dart';
import 'package:bed3avendor/view/screens/order/widget/delivery_man_assign_widget.dart';

class OrderSetup extends StatefulWidget {
  final String? orderType;
  final Order? orderModel;
  final bool onlyDigital;
  const OrderSetup(
      {Key? key, this.orderType, this.orderModel, this.onlyDigital = false})
      : super(key: key);

  @override
  State<OrderSetup> createState() => _OrderSetupState();
}

class _OrderSetupState extends State<OrderSetup> {
  @override
  Widget build(BuildContext context) {
    print('==order status=>${widget.orderModel!.orderStatus}');
    bool inHouseShipping = false;
    String? shipping = Provider.of<SplashProvider>(context, listen: false)
        .configModel!
        .shippingMethod;
    if (shipping == 'inhouse_shipping' &&
        (widget.orderModel!.orderStatus == 'out_for_delivery' ||
            widget.orderModel!.orderStatus == 'delivered' ||
            widget.orderModel!.orderStatus == 'returned' ||
            widget.orderModel!.orderStatus == 'failed' ||
            widget.orderModel!.orderStatus == 'canceled')) {
      inHouseShipping = true;
    } else {
      inHouseShipping = false;
    }

    final formKey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: getTranslated('order_setup', context),
          isBackButtonExist: true),
      body: Column(
        children: [
          Consumer<OrderProvider>(builder: (context, order, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.PADDING_SIZE_MEDIUM,
                ),
                inHouseShipping
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Dimensions.PADDING_SIZE_DEFAULT,
                            Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            Dimensions.PADDING_SIZE_DEFAULT,
                            Dimensions.PADDING_SIZE_SMALL),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: .5,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.125)),
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(.12),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(Dimensions.PADDING_SIZE),
                              child: Text(getTranslated(
                                  widget.orderModel!.orderStatus, context)!),
                            )),
                      )
                    : CustomDropDownItem(
                        title: 'order_status',
                        widget: DropdownButtonFormField<String>(
                          value: widget.orderModel!.orderStatus,
                          isExpanded: true,
                          decoration: InputDecoration(border: InputBorder.none),
                          iconSize: 24,
                          elevation: 16,
                          style: robotoRegular,
                          onChanged: (value) {
                            print('======Selected type==$value======');
                            if (value == 'canceled') {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return Container(
                              //       child: Form(
                              //         key: formKey,
                              // child: Column(
                              //   children: [
                              //     TextFormField(
                              //       controller: textEditingController,
                              //       validator: (value) {
                              //         if (value!.isEmpty) {
                              //           Fluttertoast.showToast(
                              //               msg:
                              //                   'من فضلك أدخب سبب الالغاء');
                              //         }
                              //         return null;
                              //       },
                              //     ),
                              //     ElevatedButton(
                              // onPressed: () {
                              //   if (formKey.currentState!
                              //       .validate()) {
                              //     order
                              //         .updateOrderStatus(
                              //             widget.orderModel!.id,
                              //             value,
                              //             context)
                              //         .then((value) {
                              //       Provider.of<OrderProvider>(
                              //               context,
                              //               listen: false)
                              //           .getHomeScreenData(
                              //               context);
                              //     });
                              //   }
                              // },
                              //         child: Text('تاكيد'))
                              //   ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );

                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0)),
                                ),
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return CustomBottomSheet(formkey: formKey,
                                      onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      order
                                          .updateReasonOfCancelOrder(
                                              widget.orderModel!.id,
                                              textEditingController.text,
                                              context)
                                          .then((values) {
                                        order
                                            .updateOrderStatus(
                                                widget.orderModel!.id,
                                                value,
                                                context)
                                            .then((value) {
                                          order.getHomeScreenData(context);
                                          Navigator.pop(context);
                                        });
                                      });
                                    }
                                  }, textEditingController);
                                },
                              );
                            } else {
                              order
                                  .updateOrderStatus(
                                      widget.orderModel!.id, value, context)
                                  .then((value) {
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .getHomeScreenData(context);
                              });
                            }
                          },
                          items: order.orderStatusList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(getTranslated(value, context)!,
                                  style: robotoRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color)),
                            );
                          }).toList(),
                        ),
                      ),
                CustomDropDownItem(
                  title: 'payment_status',
                  widget: DropdownButtonFormField<String>(
                    value: widget.orderModel!.paymentStatus,
                    isExpanded: true,
                    decoration: InputDecoration(border: InputBorder.none),
                    iconSize: 24,
                    elevation: 16,
                    style: robotoRegular,
                    onChanged: (value) {
                      order.setPaymentMethodIndex(value == 'paid' ? 0 : 1);
                      order.updatePaymentStatus(
                          orderId: widget.orderModel!.id,
                          status: value,
                          context: context);
                    },
                    items: <String>['paid', 'unpaid'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(getTranslated(value, context)!,
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color)),
                      );
                    }).toList(),
                  ),
                ),
                !widget.onlyDigital
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: DeliveryManAssignWidget(
                            orderType: widget.orderType,
                            orderModel: widget.orderModel,
                            orderId: widget.orderModel!.id),
                      )
                    : SizedBox(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  TextEditingController? textController;
  void Function()? onPressed;
  final formkey;
  CustomBottomSheet(this.textController,
      {required this.onPressed, required this.formkey});
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: widget.formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: 3,
                  decoration:
                      InputDecoration(hintText: ' اكتب سبب الغاء الطلب! '),
                  controller: widget.textController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      Fluttertoast.showToast(msg: 'من فضلك أدخب سبب الالغاء');
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: widget.onPressed,
                    child: Text(
                      'تاكيد',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}

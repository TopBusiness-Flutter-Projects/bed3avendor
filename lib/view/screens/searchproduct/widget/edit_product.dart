import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/orders_status_model.dart';
import '../../../../provider/search_product_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({super.key, required this.mainOrder});
  MainOrderStatus mainOrder;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, order, child) {
        return Container(
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        widget.mainOrder.name ?? '',
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.PADDING_SIZE_MEDIUM,
                            color: Colors.white),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(getTranslated('price', context)!,
                    style: titilliumRegular.copyWith(
                        color: ColorResources.getTextColor(context))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          if (widget.mainOrder.purchasePrice != null &&
                              widget.mainOrder.purchasePrice! >= 0) {
                            widget.mainOrder.purchasePrice =
                                widget.mainOrder.purchasePrice! + 1;
                          } else {
                            widget.mainOrder.purchasePrice = 0;
                          }
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
                              Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06)),
                    ),
                    Spacer(),
                    Text("${widget.mainOrder.purchasePrice.toString()} ج.م",
                        style: titilliumRegular.copyWith(
                            color: ColorResources.getTextColor(context))),
                    Spacer(),
                    Container(
                      child: InkWell(
                        onTap: () {
                          if (widget.mainOrder.purchasePrice != null &&
                              widget.mainOrder.purchasePrice! > 0) {
                            widget.mainOrder.purchasePrice =
                                widget.mainOrder.purchasePrice! - 1;
                          } else {
                            widget.mainOrder.purchasePrice = 0;
                          }
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
                              Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                          color: Colors.red.withOpacity(.06)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text('المتاح فى المخزن',
                    style: titilliumRegular.copyWith(
                        color: ColorResources.getTextColor(context))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.mainOrder.currentStock != null &&
                            widget.mainOrder.currentStock! >= 0) {
                          widget.mainOrder.currentStock =
                              widget.mainOrder.currentStock! + 1;
                        } else {
                          widget.mainOrder.currentStock = 0;
                        }
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
                                Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.06)),
                      ),
                    ),
                    Spacer(),
                    Text(widget.mainOrder.currentStock.toString(),
                        style: titilliumRegular.copyWith(
                            color: ColorResources.getTextColor(context))),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (widget.mainOrder.currentStock != null &&
                            widget.mainOrder.currentStock! > 0) {
                          widget.mainOrder.currentStock =
                              widget.mainOrder.currentStock! - 1;
                        } else {
                          widget.mainOrder.currentStock = 0;
                        }
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
                                Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                            color: Colors.red.withOpacity(.06)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text("الحد الاقصى",
                    style: titilliumRegular.copyWith(
                        color: ColorResources.getTextColor(context))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.mainOrder.minQty != null &&
                            widget.mainOrder.minQty! > 0) {
                          widget.mainOrder.minQty =
                              widget.mainOrder.minQty! + 1;
                        } else {
                          widget.mainOrder.minQty = 0;
                        }
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
                                Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.06)),
                      ),
                    ),
                    Spacer(),
                    Text(widget.mainOrder.minQty.toString(),
                        style: titilliumRegular.copyWith(
                            color: ColorResources.getTextColor(context))),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (widget.mainOrder.minQty != null &&
                            widget.mainOrder.minQty! > 0) {
                          widget.mainOrder.minQty =
                              widget.mainOrder.minQty! - 1;
                        } else {
                          widget.mainOrder.minQty = 0;
                        }
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
                                Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                            color: Colors.red.withOpacity(.06)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomButton(
                  btnTxt: 'حفظ التعديلات',
                  onTap: () {
                    order.updateproductDetails(context,
                        id: widget.mainOrder.id!,
                        price: widget.mainOrder.purchasePrice ?? 0,
                        stock: widget.mainOrder.currentStock ?? 0,
                        minQty: widget.mainOrder.minQty ?? 0);
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
  }
}

import 'package:bed3avendor/utill/app_constants.dart';
import 'package:bed3avendor/view/screens/searchproduct/widget/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/search_product_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_image.dart';
import '../../base/custom_search_field.dart';
import 'widget/addoffer.dart';
import 'widget/custombutton.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});
  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  void initState() {
    Provider.of<SearchProvider>(context, listen: false)
        .getOrderDependOnStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: getTranslated('products', context), isBackButtonExist: false),
      body: RefreshIndicator(onRefresh: () async {
        Provider.of<SearchProvider>(context, listen: false)
            .getOrderDependOnStatus(context);
        // return true;
      }, child: Consumer<SearchProvider>(builder: (context, order, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_MEDIUM,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SIZE_MEDIUM,
                  Dimensions.PADDING_SIZE_DEFAULT),
              child: CustomSearchField(
                controller: order.searchController,
                hint: getTranslated('search', context),
                prefix: Images.icons_search,
                iconPressed: () => () {},
                onSubmit: (text) => () {
                  setState(() {
                    if (order.searchController.text.isEmpty) {
                      order.getOrderDependOnStatus(context);
                    } else {
                      order.searchForOrders(search: text, context: context);
                    }
                  });
                },
                onChanged: (value) {
                  setState(() {
                    if (order.searchController.text.isEmpty) {
                      order.getOrderDependOnStatus(context);
                    } else {
                      order.searchForOrders(search: value, context: context);
                    }
                  }); //  Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1, value);
                  //
                },
                isFilter: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: SizedBox(
                height: 40,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductTypeButton(
                        text: getTranslated('notavailable', context),
                        index: 1,
                        refundList: []),
                    SizedBox(width: 5),
                    ProductTypeButton(
                        text: getTranslated('available', context),
                        index: 0,
                        refundList: []),
                    SizedBox(width: 5),
                    ProductTypeButton(
                        text: getTranslated('offers', context),
                        index: 2,
                        refundList: []),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            // DeliveryManListView(),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: order.mainOrderStatus.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.PADDING_SIZE_SMALL)),
                                  child: Container(
                                      width: Dimensions.PRODUCT_IMAGE_SIZE_ITEM,
                                      height:
                                          Dimensions.PRODUCT_IMAGE_SIZE_ITEM,
                                      child: CustomImage(
                                          image:
                                              "${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${order.mainOrderStatus[index].thumbnail!}")),
                                ),
                                SizedBox(
                                  width: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          order.mainOrderStatus[index].name ??
                                              '',
                                          style: robotoMedium.copyWith(
                                              fontSize: Dimensions
                                                  .PADDING_SIZE_MEDIUM),
                                        ),
                                        // Text(
                                        //   'كرتونه 12 كيس',
                                        //   style: robotoMedium.copyWith(
                                        //       color: ColorResources
                                        //           .nevDefaultColor),
                                        // ),
                                        Row(
                                          children: [
                                            Text(
                                              'المتاح فى المخزون ',
                                              style: robotoMedium.copyWith(
                                                  color: ColorResources
                                                      .nevDefaultColor),
                                            ),
                                            Text(
                                                order.mainOrderStatus[index]
                                                    .currentStock
                                                    .toString(),
                                                style: robotoMedium.copyWith()),
                                          ],
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        btnTxt:
                                            getTranslated('available', context),
                                        borderRadius:
                                            Dimensions.PADDING_SIZE_SMALL,
                                        backgroundColor: ColorResources.GREEN,
                                      ),
                                      Text(
                                          'السعر ${order.mainOrderStatus[index].purchasePrice!.toStringAsFixed(2)} ج.م',
                                          style: TextStyle(
                                              fontSize: 12,
                                              decoration:
                                                  order.refundTypeIndex == 2
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                              decorationColor:
                                                  order.refundTypeIndex == 2
                                                      ? Colors.red
                                                      : Colors.white)),
                                      order.refundTypeIndex == 2
                                          ? Text(
                                              ' الخصم ${(order.mainOrderStatus[index].purchasePrice! - (order.mainOrderStatus[index].purchasePrice! * order.mainOrderStatus[index].discount! / 100)).toStringAsFixed(2)}ج.م',
                                              style: TextStyle(fontSize: 12))
                                          : Container(height: 0, width: 0),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_LARGE,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width / 10,
                              child: Row(
                                children: [
                                  (order.refundTypeIndex == 1)
                                      ? Container(height: 0)
                                      : Text(
                                          order.mainOrderStatus[index].published
                                                      .toString() ==
                                                  "0"
                                              ? "معلق"
                                              : 'منشور',
                                          style: robotoMedium.copyWith(),
                                        ),
                                  (order.refundTypeIndex == 0 ||
                                          order.refundTypeIndex == 2)
                                      ? Switch(
                                          value: order.mainOrderStatus[index]
                                                      .published
                                                      .toString() ==
                                                  "0"
                                              ? false
                                              : true,
                                          onChanged: (value) {
                                            /// method >> :: change status
                                            order.updateOrderStatus(context,
                                                id: order.mainOrderStatus[index]
                                                    .id!);
                                            if (order.mainOrderStatus[index]
                                                    .published
                                                    .toString() ==
                                                "0") {
                                              setState(() {
                                                order.mainOrderStatus[index]
                                                    .published = 1;
                                              });
                                            } else {
                                              setState(() {
                                                order.mainOrderStatus[index]
                                                    .published = 0;
                                              });
                                            }
                                          },
                                        )
                                      : order.refundTypeIndex == 1
                                          ? TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        ColorResources
                                                            .getPrimary(
                                                                context)),
                                              ),
                                              onPressed: () {
                                                order.addProductToSeller(
                                                    context,
                                                    id: order
                                                        .mainOrderStatus[index]
                                                        .id
                                                        .toString());
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'أضف',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
                                          : Container(height: 0),
                                  (order.refundTypeIndex == 1 ||
                                          order.refundTypeIndex == 2)
                                      ? Flexible(
                                          fit: FlexFit.tight,
                                          child: Container(width: 0))
                                      : Flexible(
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (con) =>
                                                      AddofferForProductScreen(
                                                          title: order
                                                                  .mainOrderStatus[
                                                                      index]
                                                                  .name ??
                                                              '',
                                                          id: order
                                                              .mainOrderStatus[
                                                                  index]
                                                              .id!));
                                              ////////
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.06),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(Dimensions
                                                          .PADDING_SIZE_SMALL))),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.local_offer,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .PADDING_SIZE,
                                                      ),
                                                      Text(
                                                        'اضف عرض',
                                                        style: robotoMedium
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    width: Dimensions.PADDING_SIZE_LARGE,
                                  ),
                                  order.refundTypeIndex == 1
                                      ? Container(
                                          height: 0,
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    ColorResources.getPrimary(
                                                        context)),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (con) =>
                                                    EditProductScreen(
                                                      mainOrder:
                                                          order.mainOrderStatus[
                                                              index],
                                                    ));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .width /
                                            //     8,
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            alignment: Alignment.center,

                                            child: Text('تعديل',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            // child: Center(
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.all(8.0),
                                            //     child: Row(
                                            //       children: [
                                            //         // SizedBox(width: 20),
                                            //         // Text(
                                            //         //     '${getTranslated('edit', context) ?? ''}',
                                            //         //     style: robotoMedium
                                            //         //         .copyWith(
                                            //         //             color: Colors
                                            //         //                 .white))
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                  SizedBox(width: 5),
                                  order.refundTypeIndex == 1
                                      ? Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    ColorResources.getPrimary(
                                                        context)),
                                          ),
                                          onPressed: () {
                                            order.refundTypeIndex == 2
                                                ? order.deleteOfferFromSeller(
                                                    id: order
                                                        .mainOrderStatus[index]
                                                        .id
                                                        .toString(),
                                                    context: context)
                                                : order.deleteProductFromSeller(
                                                    id: order
                                                        .mainOrderStatus[index]
                                                        .id
                                                        .toString(),
                                                    context: context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text('حذف',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        );
      })),
    );
  }
}

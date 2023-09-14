import 'package:bed3avendor/view/screens/searchproduct/widget/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/edt_product_model.dart';
import '../../../data/model/response/refund_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/search_product_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_delegate.dart';
import '../../base/custom_image.dart';
import '../../base/custom_search_field.dart';
import '../refund/refund_screen.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class ProductTypeButton extends StatelessWidget {
  final String? text;
  final int index;
  final List<RefundModel>? refundList;

  ProductTypeButton(
      {required this.text, required this.index, required this.refundList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Provider.of<SearchProvider>(context, listen: false).setIndex(index),
      child: Consumer<SearchProvider>(
        builder: (context, refund, child) {
          return Container(
            height: 40,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: refund.refundTypeIndex == index
                  ? Theme.of(context).primaryColor
                  : ColorResources.getButtonHintColor(context),
              borderRadius:
                  BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            ),
            child: Text(text!,
                style: refund.refundTypeIndex == index
                    ? titilliumBold.copyWith(
                        color: refund.refundTypeIndex == index
                            ? ColorResources.getWhite(context)
                            : ColorResources.getTextColor(context))
                    : robotoRegular.copyWith(
                        color: refund.refundTypeIndex == index
                            ? ColorResources.getWhite(context)
                            : ColorResources.getTextColor(context))),
          );
        },
      ),
    );
  }
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: getTranslated('products', context), isBackButtonExist: false),
      body: RefreshIndicator(
        onRefresh: () async {
          // Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1,'');
          //   return true;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_MEDIUM,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SIZE_MEDIUM,
                  Dimensions.PADDING_SIZE_DEFAULT),
              child: CustomSearchField(
                controller: TextEditingController(),
                hint: getTranslated('search', context),
                prefix: Images.icons_search,
                iconPressed: () => () {},
                onSubmit: (text) => () {},
                onChanged: (value) {
                  //  Provider.of<DeliveryManProvider>(context, listen: false).deliveryManListURI(context, 1, value);
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
                        text: getTranslated('available', context),
                        index: 0,
                        refundList: []),
                    SizedBox(width: 5),
                    ProductTypeButton(
                        text: getTranslated('notavailable', context),
                        index: 1,
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
            Expanded(
                child: ListView.builder(
              itemCount: 10,
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
                                    height: Dimensions.PRODUCT_IMAGE_SIZE_ITEM,
                                    child: CustomImage(
                                        image:
                                            "https://c8.alamy.com/comp/2AGDWW8/assorted-fresh-ripe-fruit-red-yellow-and-green-vegetables-market-harvesting-agricultural-products-mixed-vegetables-and-fruits-background-healthy-foo-2AGDWW8.jpg"),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          'كيس موتزريلا 180 جرام',
                                          style: robotoMedium.copyWith(
                                              fontSize: Dimensions
                                                  .PADDING_SIZE_MEDIUM),
                                        ),
                                        Text(
                                          'كرتونه 12 كيس',
                                          style: robotoMedium.copyWith(
                                              color: ColorResources
                                                  .nevDefaultColor),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'المتاح فى المخزون ',
                                              style: robotoMedium.copyWith(
                                                  color: ColorResources
                                                      .nevDefaultColor),
                                            ),
                                            Text(
                                              'غير محدود ',
                                              style: robotoMedium.copyWith(),
                                            ),
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
                                        'السعر 3200 ج.م',
                                        style: robotoMedium.copyWith(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    'منشور',
                                    style: robotoMedium.copyWith(),
                                  ),
                                  Switch(
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/3.5,

                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.06),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions
                                                .PADDING_SIZE_SMALL))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.local_offer,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: Dimensions.PADDING_SIZE,),
                                            Text(
                                              'اضف عرض',
                                              style: robotoMedium.copyWith(
                                                  color:Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (con) => EditProductScreen()
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/3.5,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Dimensions
                                                  .PADDING_SIZE_SMALL))),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  color: Colors.white),
                                              SizedBox(width: 20,),

                                              Text(
                                                '${getTranslated('edit', context)}',
                                                style: robotoMedium.copyWith(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
        ),
      ),
    );
  }
}

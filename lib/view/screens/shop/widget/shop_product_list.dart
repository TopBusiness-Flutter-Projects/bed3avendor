import 'package:flutter/material.dart';
import 'package:bed3avendor/data/model/response/product_model.dart';
import 'package:bed3avendor/view/screens/shop/widget/shop_product_card.dart';

class ShopProductList extends StatelessWidget {
  final List<Product>? productList;
  const ShopProductList({Key? key, this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList!.length,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ShopProductWidget(productModel: productList![index],);
      },
    );
  }
}

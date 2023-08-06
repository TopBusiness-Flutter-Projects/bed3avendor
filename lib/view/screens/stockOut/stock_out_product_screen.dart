import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/product_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/screens/home/widget/stock_out_product_widget.dart';
class StockOutProductScreen extends StatelessWidget {
  const StockOutProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: getTranslated('stock_out_product',context)),
      body: RefreshIndicator(
        onRefresh: () async{
          Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, context, 'en');
        },
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          child: StockOutProductView(isHome: false),
        ),
      ),
    );
  }
}

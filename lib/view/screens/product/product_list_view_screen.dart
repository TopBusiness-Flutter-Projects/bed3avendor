import 'package:flutter/material.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/screens/product/most_popular_product.dart';
import 'package:bed3avendor/view/screens/product/top_selling_product.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final bool isPopular;
  const ProductListScreen({Key? key, required this.title, this.isPopular = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: title != null ? getTranslated(title, context) : "",),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(child: isPopular?
         MostPopularProductScreen():
         TopSellingProductScreen(scrollController: _scrollController)),
      ),

    );
  }
}

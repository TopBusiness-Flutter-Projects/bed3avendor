import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/product_provider.dart';
import 'package:bed3avendor/provider/profile_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/base/custom_search_field.dart';
import 'package:bed3avendor/view/screens/shop/widget/all_product_widget.dart';




class ProductListMenuScreen extends StatefulWidget {
  const ProductListMenuScreen({Key? key}) : super(key: key);
  @override
  State<ProductListMenuScreen> createState() => _ProductListMenuScreenState();
}

class _ProductListMenuScreenState extends State<ProductListMenuScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    int? userId = Provider.of<ProfileProvider>(context, listen: false).userId;
    Provider.of<ProductProvider>(context, listen: false).initSellerProductList(userId.toString(), 1, context, 'en','', reload: true);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('product_list', context) ,),
      body: Column(
        children: [
          Container(height: 80,
            child: Consumer<ProductProvider>(
                builder: (context, searchProductController, _) {
                  return Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_DEFAULT),
                      child: CustomSearchField(
                        controller: searchController,
                        hint: getTranslated('search', context),
                        prefix: Images.icons_search,
                        iconPressed: () => (){},
                        onSubmit: (text) => (){},
                        onChanged: (value){
                          if(value.toString().isNotEmpty){
                            searchProductController.initSellerProductList(userId.toString(), 1, context, 'en',value, reload: true);
                          }

                        },
                      ),
                    ),
                  );
                }
            )),
          Expanded(child: ProductView(sellerId: userId))
        ],
      ),

    );
  }
}

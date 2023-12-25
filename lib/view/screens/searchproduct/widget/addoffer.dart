import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/view/base/custom_button.dart';
import 'package:bed3avendor/view/base/textfeild/custom_text_feild.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../provider/search_product_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class AddofferForProductScreen extends StatefulWidget {
  AddofferForProductScreen({super.key, required this.id, required this.title});
  int id;
  String title;
  @override
  State<AddofferForProductScreen> createState() =>
      _AddofferForProductScreenState();
}

class _AddofferForProductScreenState extends State<AddofferForProductScreen> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, order, child) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Form(
            key: key,
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
                          widget.title,
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
                  child: Text('نوع الخصم (نسبه / قيمه)',
                      style: titilliumRegular.copyWith(
                          color: ColorResources.getTextColor(context))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    children: [
                      DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          order.discountType ?? 'percent',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: order.items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        // value: order.discountType,
                        onChanged: (String? value) {
                          setState(() {
                            order.discountType = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text('قيمة العرض',
                      style: titilliumRegular.copyWith(
                          color: ColorResources.getTextColor(context))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: CustomTextField(
                    border: true,
                    controller: order.discountController,
                    textInputType: TextInputType.number,
                    hintText: 'ادخل العرض',
                    isValidator: true,
                    validatorMessage: 'من فضلك أدخل قيمة العرض',
                    variant: true,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomButton(
                    btnTxt: 'حفظ التعديلات',
                    onTap: () {
                      if (key.currentState!.validate()) {
                        order.updateOfferOfProduct(
                            id: widget.id,
                            context: context,
                            discount: order.discountController.text,
                            discountType: order.discountType ?? 'percent');
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              ],
            ),
          ),
        );
      },
    );
  }
}

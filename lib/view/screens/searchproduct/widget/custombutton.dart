import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/refund_model.dart';
import '../../../../provider/search_product_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class ProductTypeButton extends StatelessWidget {
  final String? text;
  final int index;
  final List<RefundModel>? refundList;
  ProductTypeButton(
      {required this.text, required this.index, required this.refundList});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<SearchProvider>(context, listen: false)
          .setIndex(index, context),
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
            child: Text(text ?? '',
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

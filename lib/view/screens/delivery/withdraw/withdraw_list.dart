import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/data/model/response/delivery_man_withdraw_model.dart';
import 'package:bed3avendor/provider/delivery_man_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/view/base/no_data_screen.dart';
import 'package:bed3avendor/view/screens/delivery/withdraw/withdraw_card.dart';



class WithdrawListView extends StatelessWidget {
  const WithdrawListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
      builder: (context, deliveryManProvider, child) {
        List<Withdraws> withdrawList;
        withdrawList = deliveryManProvider.withdrawList;


        return Column(mainAxisSize: MainAxisSize.min, children: [
          withdrawList != null ? withdrawList.length != 0 ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL,
                vertical: Dimensions.PADDING_SIZE_SMALL),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: withdrawList.length,
              itemBuilder: (context, index) {
                return WithdrawCardWidget(withdraw: withdrawList[index], index: index);
              },
            ),
          ): NoDataScreen() :SizedBox.shrink(),

          deliveryManProvider.isLoading ? Center(child: Padding(
            padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : SizedBox.shrink(),

        ]);
      },
    );
  }
}

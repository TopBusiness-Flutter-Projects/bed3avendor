import 'package:flutter/material.dart';
import 'package:bed3avendor/provider/transaction_provider.dart';
import 'package:bed3avendor/view/screens/transaction/widget/transaction_widget.dart';
class WalletTransactionListView extends StatelessWidget {
  final TransactionProvider? transactionProvider;
  const WalletTransactionListView({Key? key, this.transactionProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactionProvider!.transactionList!.length,
      itemBuilder: (context, index) => TransactionWidget(transactionModel: transactionProvider!.transactionList![index]),
    ),);
  }
}

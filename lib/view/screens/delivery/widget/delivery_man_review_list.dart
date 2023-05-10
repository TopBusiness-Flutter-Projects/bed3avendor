import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/data/model/response/delivery_man_review_model.dart';
import 'package:bed3avendor/data/model/response/top_delivery_man.dart';
import 'package:bed3avendor/provider/delivery_man_provider.dart';
import 'package:bed3avendor/view/base/no_data_screen.dart';
import 'package:bed3avendor/view/screens/delivery/widget/delivery_man_review_card.dart';

class DeliveryManReviewList extends StatelessWidget {
  final DeliveryMan deliveryMan;
  const DeliveryManReviewList({Key key, this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(
        builder: (context, review, _) {
          List<DeliveryManReview> _reviewList = [];
          _reviewList = review.deliveryManReviewList;
          return _reviewList.isNotEmpty?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _reviewList.length,
              itemBuilder: (context, index){
                return DeliveryManReviewItem(reviewModel: _reviewList[index]);
              }):NoDataScreen();
        }
    );
  }
}

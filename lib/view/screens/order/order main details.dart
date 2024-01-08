import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/order_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/order_provider.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../../base/paginated_list_view.dart';
import '../home/widget/order_widget.dart';
import 'order_screen.dart';

//! details of order
class MainOrderDetails extends StatefulWidget {
  MainOrderDetails({
    super.key,
    required this.title,
    required this.scrollController,
    // required this.order,
    // required this.orderList
  });
  // OrderModel? orderModel;
  // List<Order>? orderList;
  // OrderProvider order;
  String title;
  ScrollController? scrollController;
  @override
  State<MainOrderDetails> createState() => _MainOrderDetailsState();
}

class _MainOrderDetailsState extends State<MainOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, order, child) {
      List<Order>? orderList = [];
      orderList = order.orderModel?.orders;
      return Scaffold(
        appBar: CustomAppBar(title: widget.title, isBackButtonExist: true),
        body: order.orderModel != null
            ? orderList!.length > 0
                ? RefreshIndicator(
                    onRefresh: () async {
                      await order.getOrderList(context, 1, order.orderType);
                    },
                    child: SingleChildScrollView(
                      controller: widget.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: PaginatedListView(
                        reverse: false,
                        scrollController: widget.scrollController,
                        totalSize: order.orderModel?.totalSize,
                        offset: order.orderModel != null
                            ? int.parse(order.orderModel!.offset.toString())
                            : null,
                        onPaginate: (int? offset) async {
                          await order.getOrderList(
                              context, offset!, order.orderType,
                              reload: false);
                        },
                        itemView: ListView.builder(
                          itemCount: orderList.length,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderWidget(
                              orderModel: orderList![index],
                              index: index,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : NoDataScreen(
                    title: 'no_order_found',
                  )
            : OrderShimmer(),
      );
    });
  }
}

import 'package:bed3avendor/view/screens/order/order%20main%20details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bed3avendor/data/model/response/order_model.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/base/no_data_screen.dart';
import 'package:bed3avendor/view/base/paginated_list_view.dart';
import 'package:bed3avendor/view/screens/home/widget/order_widget.dart';

class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  final bool fromHome;
  OrderScreen({this.isBacButtonExist = false, this.fromHome = false});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: CustomAppBar(
          title: getTranslated('my_order', context),
          isBackButtonExist: widget.isBacButtonExist),
      body: Consumer<OrderProvider>(
        builder: (context, order, child) {
          List<Order>? orderList = [];
          orderList = order.orderModel?.orders;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // OrderTypeButton(text: getTranslated('all', context), index: 0, ),
                      // SizedBox(width: 5),
                      OrderTypeButton(
                          order: order,
                          orderList: orderList,
                          orderModel: order.orderModel,
                          scrollController: scrollController,
                          text: getTranslated('pending', context),
                          index: 0),
                      SizedBox(width: 5),
                      OrderTypeButton(
                          order: order,
                          orderList: orderList,
                          orderModel: order.orderModel,
                          scrollController: scrollController,
                          text: getTranslated('processing', context),
                          index: 1),
                      SizedBox(width: 5),
                      OrderTypeButton(
                          order: order,
                          orderList: orderList,
                          orderModel: order.orderModel,
                          scrollController: scrollController,
                          text: getTranslated('in_way', context),
                          index: 2),
                      SizedBox(width: 5),
                      OrderTypeButton(
                          order: order,
                          orderList: orderList,
                          orderModel: order.orderModel,
                          scrollController: scrollController,
                          text: getTranslated('delivered', context),
                          index: 3),
                      SizedBox(width: 5),
                      // OrderTypeButton(text: getTranslated('return', context), index: 4),
                      // SizedBox(width: 5),
                      // OrderTypeButton(text: getTranslated('failed', context), index: 5),
                      // SizedBox(width: 5),
                      OrderTypeButton(
                          order: order,
                          orderList: orderList,
                          orderModel: order.orderModel,
                          scrollController: scrollController,
                          text: getTranslated('cancelled', context),
                          index: 4),
                      SizedBox(width: 5),
                      // OrderTypeButton(text: getTranslated('confirmed', context), index: 7),
                      // SizedBox(width: 5),
                      // OrderTypeButton(text: getTranslated('out_for_delivery', context), index: 8),
                    ],
                  ),
                ),
              ),
              order.orderModel != null
                  ? orderList!.length > 0
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await order.getOrderList(
                                  context, 1, order.orderType);
                            },
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: PaginatedListView(
                                reverse: false,
                                scrollController: scrollController,
                                totalSize: order.orderModel?.totalSize,
                                offset: order.orderModel != null
                                    ? int.parse(
                                        order.orderModel!.offset.toString())
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return OrderWidget(
                                      orderModel: orderList![index],
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: NoDataScreen(
                          title: 'no_order_found',
                        ))
                  : Expanded(child: OrderShimmer()),
            ],
          );
        },
      ),
    );
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(
                                  height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderTypeButton extends StatelessWidget {
  final String? text;
  final int index;
  OrderModel? orderModel;
  List<Order>? orderList;
  OrderProvider order;
  ScrollController? scrollController;
  OrderTypeButton(
      {required this.text,
      required this.index,
      required this.orderModel,
      this.scrollController,
      required this.order,
      required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Provider.of<OrderProvider>(context, listen: false)
              .setIndex(context, index, scrollController: scrollController
                  // order: order,
                  // orderList: orderList,
                  // orderModel: orderModel,
                  // scrollController: scrollController
                  );
        },
        child: Consumer<OrderProvider>(
          builder: (context, order, child) {
            return Column(
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   color: order.orderTypeIndex == index ? Theme.of(context).primaryColor : ColorResources.getButtonHintColor(context),
                  //   borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_LARGE),
                  // ),
                  child: Text(text!,
                      style: order.orderTypeIndex == index
                          ? titilliumBold.copyWith(
                              color: order.orderTypeIndex == index
                                  ? ColorResources.getBlue(context)
                                  : ColorResources.getTextColor(context))
                          : robotoRegular.copyWith(
                              color: order.orderTypeIndex == index
                                  ? ColorResources.getBlue(context)
                                  : ColorResources.getTextColor(context))),
                ),
                SizedBox(
                  height: 2,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 2,
                          color: order.orderTypeIndex == index
                              ? Theme.of(context).primaryColor
                              : ColorResources.getButtonHintColor(context),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

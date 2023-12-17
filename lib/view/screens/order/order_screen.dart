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
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../base/custom_image.dart';
import '../splash/widget/splash_painter.dart';

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
  void initState() {
    // get HomeScreen Data
    Provider.of<OrderProvider>(context, listen: false)
        .getHomeScreenData(context);
// OrderProvider(orderRepo: orderRepo)
    super.initState();
  }

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
          return order.homeScreenModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0, vertical: Dimensions.PADDING_SIZE_SMALL),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorResources.COLOR_BLUE,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(22),
                                bottomLeft: Radius.circular(22))),
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height,
                              child: CustomPaint(
                                painter: SplashPainter(),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            Dimensions.PADDING_SIZE_SMALL,
                                            0,
                                            Dimensions.PADDING_SIZE_SMALL,
                                            0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            border: Border.all(
                                                color: Colors.white, width: 3),
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            child: CustomImage(
                                              width: 60,
                                              height: 60,
                                              image:
                                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.image ?? ''}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                              '${order.homeScreenModel!.wallet.toString()}ج',
                                              style: TextStyle(
                                                  color: ColorResources.WHITE,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          Text('الرصيد',
                                              style: TextStyle(
                                                  color: ColorResources.WHITE,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorResources.COLUMBIA_BLUE,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(2, 3),
                                                    color: Colors.black12)
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${order.homeScreenModel!.totalPrice.toString()}ج',
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('إجمالي الفواتير',
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorResources.COLUMBIA_BLUE,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(2, 3),
                                                    color: Colors.black12)
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${order.homeScreenModel!.pendingPrice.toString()}ج',
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('قيمة الفواتير المعلقه',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorResources.COLUMBIA_BLUE,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(2, 3),
                                                    color: Colors.black12)
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${order.homeScreenModel!.deliveredPrice.toString()}ج',
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('تم التوصيل',
                                                  style: TextStyle(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    Container(
                      // height: 50,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'حالة الطلب',
                        style: TextStyle(
                            color: ColorResources.PRIMARY_MATERIAL,
                            fontSize: 22),
                      ),
                    ),
                    NewOrderWidget(
                        backColor: Color(0xffd0dff6),
                        index: 0,
                        scrollController: scrollController,
                        imageName: 'assets/image/037-waiting.png',
                        title: getTranslated('pending', context) ?? '',
                        num: order.homeScreenModel!.pending.toString()),
                    // OrderTypeButton(text: getTranslated('all', context), index: 0, ),
                    // SizedBox(width: 5),
                    // OrderTypeButton(
                    //     order: order,
                    //     orderList: orderList,
                    //     orderModel: order.orderModel,
                    //     scrollController: scrollController,
                    //     text: getTranslated('pending', context),
                    //     index: 0),
                    SizedBox(height: 5),
                    NewOrderWidget(
                        backColor: Color(0xfff2e4b7),
                        scrollController: scrollController,
                        index: 1,
                        imageName: 'assets/image/051-shopping-list-1.png',
                        title: getTranslated('processing', context) ?? '',
                        num: order.homeScreenModel!.processing.toString()),
                    // OrderTypeButton(
                    //     order: order,
                    //     orderList: orderList,
                    //     orderModel: order.orderModel,
                    //     scrollController: scrollController,
                    //     text: getTranslated('processing', context),
                    //     index: 1),
                    SizedBox(height: 5),
                    NewOrderWidget(
                        index: 2,
                        backColor: Color(0xffc6f3de),
                        scrollController: scrollController,
                        imageName: 'assets/image/039-delivery-boy.png',
                        title: getTranslated('in_way', context) ?? '',
                        num: order.homeScreenModel!.outForDelivery.toString()),
                    // OrderTypeButton(
                    //     order: order,
                    //     orderList: orderList,
                    //     orderModel: order.orderModel,
                    //     scrollController: scrollController,
                    //     text: getTranslated('in_way', context),
                    //     index: 2),
                    SizedBox(height: 5),
                    NewOrderWidget(
                        backColor: Color(0xff13ea60),
                        index: 3,
                        scrollController: scrollController,
                        imageName: 'assets/image/040-received.png',
                        title: getTranslated('delivered', context) ?? '',
                        num: order.homeScreenModel!.delivered.toString()),
                    // OrderTypeButton(
                    //     order: order,
                    //     orderList: orderList,
                    //     orderModel: order.orderModel,
                    //     scrollController: scrollController,
                    //     text: getTranslated('delivered', context),
                    //     index: 3),
                    SizedBox(height: 5),
                    NewOrderWidget(
                        index: 4,
                        backColor: Color(0xffbbbbbb),
                        scrollController: scrollController,
                        imageName: 'assets/image/041-cancel.png',
                        title: getTranslated('cancelled', context) ?? '',
                        num: order.homeScreenModel!.canceled.toString()),
                    // OrderTypeButton(
                    //     order: order,
                    //     orderList: orderList,
                    //     orderModel: order.orderModel,
                    //     scrollController: scrollController,
                    //     text: getTranslated('cancelled', context),
                    //     index: 4),
                    SizedBox(height: 5),

                    //<<!todo>>>//data
                    // order.orderModel != null
                    //     ? orderList!.length > 0
                    //         ? Expanded(
                    //             child: RefreshIndicator(
                    //               onRefresh: () async {
                    //                 await order.getOrderList(
                    //                     context, 1, order.orderType);
                    //               },
                    //               child: SingleChildScrollView(
                    //                 controller: scrollController,
                    //                 child: PaginatedListView(
                    //                   reverse: false,
                    //                   scrollController: scrollController,
                    //                   totalSize: order.orderModel?.totalSize,
                    //                   offset: order.orderModel != null
                    //                       ? int.parse(
                    //                           order.orderModel!.offset.toString())
                    //                       : null,
                    //                   onPaginate: (int? offset) async {
                    //                     await order.getOrderList(
                    //                         context, offset!, order.orderType,
                    //                         reload: false);
                    //                   },
                    //                   itemView: ListView.builder(
                    //                     itemCount: orderList.length,
                    //                     padding: EdgeInsets.all(0),
                    //                     physics: NeverScrollableScrollPhysics(),
                    //                     shrinkWrap: true,
                    //                     itemBuilder:
                    //                         (BuildContext context, int index) {
                    //                       return OrderWidget(
                    //                         orderModel: orderList![index],
                    //                         index: index,
                    //                       );
                    //                     },
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         : Expanded(
                    //             child: NoDataScreen(
                    //             title: 'no_order_found',
                    //           ))
                    //     : Expanded(child: OrderShimmer()),
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
      shrinkWrap: true,
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
              .setIndex(context, index,
                  title: '',
                  // order: order,
                  // orderList: orderList,
                  // orderModel: orderModel,
                  scrollController: scrollController);
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

class NewOrderWidget extends StatelessWidget {
  NewOrderWidget(
      {super.key,
      required this.imageName,
      required this.title,
      required this.num,
      required this.backColor,
      this.scrollController,
      required this.index});
  String imageName;
  String title;
  int index;
  String num;
  ScrollController? scrollController;
  Color backColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(
            context, index,
            scrollController: scrollController, title: title);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          height: MediaQuery.of(context).size.width / 6,
          // width: MediaQuery.of(context).size.width / 2.5,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Image.asset(imageName, width: 30, height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  title,
                  style: TextStyle(color: ColorResources.BLACK, fontSize: 18),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  num,
                  style: TextStyle(color: ColorResources.BLACK, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}

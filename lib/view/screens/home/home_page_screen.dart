import 'package:bed3avendor/provider/search_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/provider/bank_info_provider.dart';
import 'package:bed3avendor/provider/delivery_man_provider.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/provider/product_provider.dart';
import 'package:bed3avendor/provider/profile_provider.dart';
import 'package:bed3avendor/provider/shipping_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/view/base/custom_loader.dart';
import 'package:bed3avendor/view/screens/home/widget/on_going_order_widget.dart';
import '../../../utill/styles.dart';

class HomePageScreen extends StatefulWidget {
  final Function? callback;
  const HomePageScreen({Key? key, this.callback}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
    Provider.of<BankInfoProvider>(context, listen: false).getBankInfo(context);
    Provider.of<OrderProvider>(context, listen: false)
        .getOrderList(context, 1, 'all');
    Provider.of<OrderProvider>(context, listen: false)
        .getAnalyticsFilterData(context, 'overall');
    Provider.of<OrderProvider>(context, listen: false)
        .getHomeScreenData(context);
    Provider.of<SearchProvider>(context, listen: false)
        .getOrderDependOnStatus(context);
    Provider.of<OrderProvider>(context, listen: false).getOrderStatisticsModel(
        context,
        startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        endDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    Provider.of<SplashProvider>(context, listen: false).getColorList();
    Provider.of<ProductProvider>(context, listen: false)
        .getStockOutProductList(1, context, 'en');
    Provider.of<ProductProvider>(context, listen: false)
        .getMostPopularProductList(1, context, 'en');
    Provider.of<ProductProvider>(context, listen: false)
        .getTopSellingProductList(1, context, 'en');
    Provider.of<ShippingProvider>(context, listen: false)
        .getCategoryWiseShippingMethod(context);
    Provider.of<ShippingProvider>(context, listen: false)
        .getSelectedShippingMethodType(context);
    Provider.of<DeliveryManProvider>(context, listen: false)
        .getTopDeliveryManList(context);
    Provider.of<BankInfoProvider>(context, listen: false)
        .getDashboardRevenueData(context, 'yearEarn');
  }

  @override
  void initState() {
    _loadData(context, false);

    super.initState();
  }

  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();
  Future<void> _selectDateStart(BuildContext context,
      {bool isEnd = false}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: isEnd ? selectedDateEnd : selectedDateStart,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2999));
    if (picked != null &&
        (picked != selectedDateStart || picked != selectedDateEnd)) {
      setState(() {
        if (isEnd) {
          selectedDateEnd = picked;
        } else {
          selectedDateStart = picked;
        }
      });
      print(DateFormat('yyyy-MM-dd').format(selectedDateStart));
      Provider.of<OrderProvider>(context, listen: false)
          .getOrderStatisticsModel(context,
              startDate: DateFormat('yyyy-MM-dd').format(selectedDateStart),
              endDate: DateFormat('yyyy-MM-dd').format(selectedDateEnd));
      //////
    }
  }

  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width / 1.4;
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return order.orderModel != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<OrderProvider>(context, listen: false)
                        .setAnalyticsFilterName(context, 'overall', true);
                    Provider.of<OrderProvider>(context, listen: false)
                        .setAnalyticsFilterType(0, true);
                    await _loadData(context, true);
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        elevation: 0,
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).highlightColor,
                        title:
                            Image.asset(Images.logo_with_app_name, height: 35),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            OngoingOrderWidget(
                              callback: widget.callback,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                              child: Text(
                                'التحليل خلال مدة محددة',
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _selectDateStart(context);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            'من',
                                            style: robotoMedium.copyWith(
                                                color: Colors.black,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(Dimensions
                                                        .PADDING_SIZE_SMALL)),
                                                border: Border.all(
                                                    color: ColorResources
                                                        .HINT_TEXT_COLOR)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              selectedDateStart),
                                                      maxLines: 1,
                                                      style: robotoMedium.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE),
                                                    ),
                                                  ),
                                                  Icon(Icons
                                                      .calendar_today_outlined)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.PADDING_SIZE,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _selectDateStart(context, isEnd: true);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            'إالى',
                                            style: robotoMedium.copyWith(
                                                color: Colors.black,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(Dimensions
                                                        .PADDING_SIZE_SMALL)),
                                                border: Border.all(
                                                    color: ColorResources
                                                        .HINT_TEXT_COLOR)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              selectedDateEnd),
                                                      maxLines: 1,
                                                      style: robotoMedium.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE),
                                                    ),
                                                  ),
                                                  Icon(Icons
                                                      .calendar_today_outlined)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_LARGE,
                            ),
                            order.orderStatisticsModel == null
                                ? CircularProgressIndicator()
                                : ListView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_MEDIUM),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.PADDING_SIZE)),
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Image.asset(
                                                      width: 70,
                                                      height: 70,
                                                      Images.confirm_purchase),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                      Text(
                                                        'عدد الفواتير المستلمة',
                                                        style: robotoMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE,
                                                            color: ColorResources
                                                                .getTextColor(
                                                                    context)),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                      ),
                                                      Text(
                                                        order
                                                            .orderStatisticsModel!
                                                            .allOrders
                                                            .toString(),
                                                        style: robotoMedium.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_MEDIUM),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.PADDING_SIZE)),
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Image.asset(
                                                      width: 70,
                                                      height: 70,
                                                      Images.confirm_purchase),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                      Text(
                                                        'عدد الفواتير المحققة',
                                                        style: robotoMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE,
                                                            color: ColorResources
                                                                .getTextColor(
                                                                    context)),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                      ),
                                                      Text(
                                                        order
                                                            .orderStatisticsModel!
                                                            .ordersDelivered
                                                            .toString(),
                                                        style: robotoMedium.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_MEDIUM),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.PADDING_SIZE)),
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Image.asset(
                                                      width: 70,
                                                      height: 70,
                                                      Images.budget),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                      Text(
                                                        'اجمالى الفواتير ',
                                                        style: robotoMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE,
                                                            color: ColorResources
                                                                .getTextColor(
                                                                    context)),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                      ),
                                                      Text(
                                                        '${order.orderStatisticsModel!.totalPrice.toString()} ج.م',
                                                        style: robotoMedium.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE,
                                      ),
                                    ],
                                  )
                            // CompletedOrderWidget(callback: widget.callback),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            // Consumer<ProductProvider>(
                            //     builder: (context, prodProvider, child) {
                            //       List<Product> productList;
                            //       productList = prodProvider.stockOutProductList;
                            //     return productList.isNotEmpty?
                            //     Container(height: limitedStockCardHeight,
                            //         decoration: BoxDecoration(
                            //           color: Theme.of(context).cardColor,
                            //           boxShadow: [
                            //             BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
                            //                 spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
                            //         ),
                            //         child: StockOutProductView(scrollController: _scrollController, isHome: true)):SizedBox();
                            //   }
                            // ),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            //
                            // ChartWidget(),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            //
                            // TopSellingProductScreen(isMain: true),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            //
                            // Container(
                            //   color: Theme.of(context).primaryColor,
                            //     child: MostPopularProductScreen(isMain: true)),
                            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            //
                            // TopDeliveryManView(isMain: true)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : CustomLoader();
        },
      ),
    );
  }
}

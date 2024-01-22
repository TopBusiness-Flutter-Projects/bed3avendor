import 'package:bed3avendor/data/model/response/orders_status_model.dart';
import 'package:flutter/material.dart';
import 'package:bed3avendor/data/model/response/base/api_response.dart';
import 'package:bed3avendor/data/model/response/refund_details_model.dart';
import 'package:bed3avendor/data/model/response/refund_model.dart';
import 'package:bed3avendor/data/repository/refund_repo.dart';
import 'package:bed3avendor/helper/api_checker.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/utill/app_constants.dart';
import 'package:bed3avendor/view/base/custom_snackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchProvider extends ChangeNotifier {
  final RefundRepo? refundRepo;
  SearchProvider({required this.refundRepo});
  TextEditingController searchController = TextEditingController();
  List<RefundModel>? _refundList;
  List<RefundModel>? get refundList =>
      _refundList != null ? _refundList : _refundList;

  List<RefundModel>? _pendingList;
  List<RefundModel>? _approvedList;
  List<RefundModel>? _deniedList;
  List<RefundModel>? _doneList;

  List<RefundModel>? get pendingList =>
      _pendingList != null ? _pendingList : _pendingList;
  List<RefundModel>? get approvedList =>
      _approvedList != null ? _approvedList : _approvedList;
  List<RefundModel>? get deniedList =>
      _deniedList != null ? _deniedList : _deniedList;
  List<RefundModel>? get doneList => _doneList != null ? _doneList : _doneList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _refundTypeIndex = 1;
  int get refundTypeIndex => _refundTypeIndex;

  List<String> _refundStatusList = [];
  String _refundStatusType = '';
  List<String> get refundStatusList => _refundStatusList;
  String get refundStatusType => _refundStatusType;

  RefundDetailsModel? _refundDetailsModel;
  RefundDetailsModel? get refundDetailsModel => _refundDetailsModel;
  bool _isSendButtonActive = false;
  bool get isSendButtonActive => _isSendButtonActive;
  bool _adminReplied = true;
  bool get adminReplied => _adminReplied;

  Future<ApiResponse> updateRefundStatus(
      BuildContext context, int? id, String status, String note) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    apiResponse = await refundRepo!.refundStatus(id, status, note);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(
          getTranslated('successfully_updated_refund_status', context), context,
          isError: false);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getRefundReqInfo(
      BuildContext context, int? orderDetailId) async {
    _isLoading = true;

    ApiResponse apiResponse =
        await refundRepo!.getRefundReqDetails(orderDetailId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _refundDetailsModel =
          RefundDetailsModel.fromJson(apiResponse.response!.data);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<void> getRefundList(BuildContext context) async {
    ApiResponse apiResponse = await refundRepo!.getRefundList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _refundList = [];
      _pendingList = [];
      _approvedList = [];
      _deniedList = [];
      _doneList = [];
      apiResponse.response!.data.forEach((refund) {
        RefundModel refundModel = RefundModel.fromJson(refund);
        _refundList!.add(refundModel);
        if (refundModel.status == AppConstants.PENDING) {
          _pendingList!.add(refundModel);
        } else if (refundModel.status == AppConstants.APPROVED) {
          _approvedList!.add(refundModel);
        } else if (refundModel.status == AppConstants.REJECTED) {
          _deniedList!.add(refundModel);
        } else if (refundModel.status == AppConstants.DONE) {
          _doneList!.add(refundModel);
        }
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void setIndex(int index, BuildContext context, {int status = -1}) {
    _refundTypeIndex = index;
    getOrderDependOnStatus(context, status: status);
    notifyListeners();
  }

  void updateStatus(String value) {
    _refundStatusType = value;
    notifyListeners();
  }

  //getOrderDependOnStatus
  List<MainOrderStatus> _mainOrderStatus = [];
  List<MainOrderStatus> get mainOrderStatus => _mainOrderStatus;

  set mainOrderStatus(List<MainOrderStatus> value) {
    _mainOrderStatus = value;
  }

  Future<void> getOrderDependOnStatus(BuildContext context,
      {int status = -1}) async {
    ApiResponse apiResponse = await refundRepo!.getOrderDependOnStatus(
        status: refundTypeIndex == 0
            ? 'available'
            : refundTypeIndex == 1
                ? 'not_available'
                : 'offer');
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      if (status == -1) {
        _mainOrderStatus = List<MainOrderStatus>.from(
          apiResponse.response!.data.map((e) => MainOrderStatus.fromJson(e)),
        );
      } else {
        _mainOrderStatus = List<MainOrderStatus>.from(apiResponse.response!.data
                .map((e) => MainOrderStatus.fromJson(e)))
            .where((element) => element.status == status)
            .toList();
      }

      ////
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateproductDetails(
    BuildContext context, {
    required int id,
    required int price,
    required int stock,
    required int minQty,
  }) async {
    ApiResponse apiResponse = await refundRepo!.updateproductDetails(
        id: id, minQty: minQty, price: price, stock: stock);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print('updateproductDetails :: 000 :: ' +
          apiResponse.response!.data.toString());
      ////
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  //udateOrderStatus
  ///add
  Future<void> addProductToSeller(BuildContext context,
      {required String id}) async {
    await refundRepo!.addProductToSeller(id: id).then((value) {
      getOrderDependOnStatus(context);
      Fluttertoast.showToast(msg: value.toString());
    });

    notifyListeners();
  }

  Future<void> updateOrderStatus(BuildContext context,
      {required int id}) async {
    ApiResponse apiResponse = await refundRepo!.updateOrderStatus(id: id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Fluttertoast.showToast(msg: apiResponse.response!.data['msg'].toString());
      ////
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateOfferOfProduct(
      {required int id,
      required String discountType,
      required String discount,
      required BuildContext context}) async {
    ApiResponse apiResponse = await refundRepo!.updateProductDiscount(
        id: id, discount: int.parse(discount), discountType: discountType);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Fluttertoast.showToast(msg: apiResponse.response!.data['msg'].toString());
      ////
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    getOrderDependOnStatus(context);
    discountController.clear();
    notifyListeners();
  }

  ///delete
  Future<void> deleteProductFromSeller(
      {required String id, required BuildContext context}) async {
    refundRepo!.deleteProductFromSeller(id: id).then((value) {
      Fluttertoast.showToast(msg: value);
      getOrderDependOnStatus(context);
    });

    notifyListeners();
  }

//delete offer
  Future<void> deleteOfferFromSeller(
      {required String id, required BuildContext context}) async {
    refundRepo!.deleteOfferFromSeller(id: id).then((value) {
      Fluttertoast.showToast(msg: value);
      getOrderDependOnStatus(context);
    });

    notifyListeners();
  }

//////////////////
  searchForOrders({required String search, required BuildContext context}) {
    refundRepo!
        .getOrderDependOnStatus(
            status: refundTypeIndex == 0
                ? 'available'
                : refundTypeIndex == 1
                    ? 'not_available'
                    : 'offer')
        .then((value) {
      _mainOrderStatus = List<MainOrderStatus>.from(
        value.response!.data
            .where((order) => order['name'].toString().contains(search))
            .map((e) => MainOrderStatus.fromJson(e)),
      );
    });

    ///
  }

  final List<String> items = ['percent ', 'flat'];
  String? discountType = 'percent';
  TextEditingController discountController = TextEditingController();
}

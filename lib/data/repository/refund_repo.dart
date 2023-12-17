import 'package:dio/dio.dart';
import 'package:bed3avendor/data/datasource/remote/dio/dio_client.dart';
import 'package:bed3avendor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:bed3avendor/data/model/response/base/api_response.dart';
import 'package:bed3avendor/utill/app_constants.dart';

class RefundRepo {
  final DioClient? dioClient;
  RefundRepo({required this.dioClient});

  Future<ApiResponse> getRefundList() async {
    try {
      final response = await dioClient!.get(AppConstants.REFUND_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRefundReqDetails(int? orderDetailsId) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.REFUND_ITEM_DETAILS}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> refundStatus(
      int? refundId, String status, String note) async {
    print(
        'update order status ====>${refundId.toString()} =======>${status.toString()}  =======>${note.toString()}');
    try {
      Response response = await dioClient!.post(
        '${AppConstants.REFUND_REQ_STATUS_UPDATE}',
        data: {
          'refund_status': status,
          'refund_request_id': refundId,
          'note': note
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRefundStatusList(String type) async {
    try {
      List<String> refundTypeList = [];

      refundTypeList = [
        'Select Refund Status',
        AppConstants.APPROVED,
        AppConstants.REJECTED,
      ];
      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: refundTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDependOnStatus(
      {String status = 'available'}) async {
    try {
      final response = await dioClient!.get(
        AppConstants.GET_ORDERS_DEPEND_ON_STATUS + status,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateOrderStatus({required int id}) async {
    try {
      final response = await dioClient!.post(
        AppConstants.UPDATE_ORDERS_STATUS,
        data: {"id": id},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateproductDetails({
    required int id,
    required int price,
    required int stock,
    required int minQty,
  }) async {
    try {
      final response = await dioClient!.post(
        AppConstants.UPDATE_ORDERS_PRICE_COUNT,
        data: {"id": id, "price": price, "stock": stock, "min_qty": minQty},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  //  static const String UPDATE_ORDERS_PRICE_COUNT =
}

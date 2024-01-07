import 'package:dio/dio.dart';
import 'package:bed3avendor/data/datasource/remote/dio/dio_client.dart';
import 'package:bed3avendor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:bed3avendor/data/model/response/base/api_response.dart';
import 'package:bed3avendor/utill/app_constants.dart';

import '../model/response/add_new_productmodel.dart';

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

//api/v3/seller/products/copy

  Future<String> addProductToSeller({required String id}) async {
    try {
      final response = await dioClient!
          .post(AppConstants.ADD_PRODUCT_TO_SELLER, data: {"id": id});
      return response.data['msg'].toString();
    } catch (e) {
      return e.toString();
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
  //  api/v3/seller/products/add-discount

  Future<ApiResponse> updateProductDiscount({
    required int id,
    required String discountType,
    required int discount,
  }) async {
    try {
      final response = await dioClient!.post(
        AppConstants.UPDATE_ORDERS_DISCOUNT_COUNT,
        data: {"id": id, "discount_type": discountType, "discount": discount},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //deleteProductFromSeller
  Future<String> deleteProductFromSeller({
    required String id,
  }) async {
    try {
      final response = await dioClient!
          .delete(AppConstants.DELETE_ORDERS_DISCOUNT_COUNT + id);
      return response.data['message'];
    } catch (e) {
      return e.toString();
    }
  }

  //deleteOfferFromSeller
  Future<String> deleteOfferFromSeller({required String id}) async {
    try {
      final response = await dioClient!.post(
        AppConstants.DELETE_OFFER_FROM_ORDER,
        data: FormData.fromMap({"id": id}),
      );
      return response.data['msg'];
    } catch (e) {
      return e.toString();
    }
  }
}

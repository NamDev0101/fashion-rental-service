import 'dart:convert';
import 'package:frs_mobile/representation/screens/customer/account/orderHistoryCustomer/rental_order_history/models/order_rent_detail_model.dart';
import 'package:frs_mobile/representation/screens/customer/account/orderHistoryCustomer/rental_order_history/models/order_rent_model.dart';
import 'package:http/http.dart' as http;

class ApiOderRentHistory {
  static Future<bool> checkIsFeedback(int orderRentID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/feedback/check/$orderRentID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        throw Exception('Kiểm tra trạng thái đánh giá thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllPendingOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/pending/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order pending thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<void> updateOrderCusRejecting(
      int orderRentID, String reason) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/rejecting?orderRentID=${orderRentID}&reason=${reason}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'orderRentID ': orderRentID,
          'reason': reason,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gửi lý do không thành công');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllPrepareOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/prepare/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order prepare thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllDeliveryOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/delivery/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order ready_pickup thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllConfirmingOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/confirming/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order confirm thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllRentingOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/renting/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order renting thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllReturningOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/returning/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order returning thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllCompletedOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/completed/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order completed thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllRejectingOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/rejecting/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order rejecting thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?> getAllCanceledOrderRentByCustomerID(
      int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/cancel/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order canceled thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentModel>?>
      getAllRejectingCompletedOrderRentByCustomerID(int customerID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent/cus/rejectcompleted/$customerID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderRentModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order rejecting completed thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<void> updateStatusOrderRent(
      int orderRentID, String status) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrent?orderRentID=${orderRentID}&status=${status}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'orderRentID': orderRentID,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Cập nhật status không thành công');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<OrderRentDetailModel>?> getAllOrderRentDetailByOrderRentID(
      int orderRentID) async {
    final url = Uri.parse(
        'http://fashionrental.online:8080/orderrentdetail/$orderRentID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList
              .map((json) => OrderRentDetailModel.fromJson(json))
              .toList();
        }
      } else {
        throw Exception('Lấy chi tiết đơn hàng thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<void> createNewPic(
      int accountID, List<String> img, int orderRentID, String status) async {
    final url = Uri.parse('http://fashionrental.online:8080/pic');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'accountID': accountID,
          'img': img,
          'orderRentID': orderRentID,
          'status': status
        }),
      );

      if (response.statusCode == 200) {
        print('API createNewPic thành công.');
      } else {
        throw Exception('API createNewPic thất bại: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi gọi API createNewPic: $e');
    }
  }
}

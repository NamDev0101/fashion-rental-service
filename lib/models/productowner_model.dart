import 'package:frs_mobile/models/account_dto.dart';

class ProductOwnerModel {
  int productOwnerID;
  String fullName;
  String phone;
  String avatarUrl;
  String address;
  int reputationPoint;
  AccountDTO? accountDTO;

  ProductOwnerModel({
    required this.productOwnerID,
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    required this.address,
    required this.reputationPoint,
    this.accountDTO,
  });

  factory ProductOwnerModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductOwnerModel(
      productOwnerID: json['productownerID'],
      fullName: json['fullName'],
      phone: json['phone'],
      avatarUrl: json['avatarUrl'],
      address: json['address'],
      reputationPoint: json['reputationPoint'],
      accountDTO: AccountDTO.fromJson(json['accountDTO']),
    );
  }
  Map<dynamic, dynamic> toJson() {
    return {
      'productownerID': productOwnerID,
      'fullName': fullName,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'address': address,
      'reputationPoint': reputationPoint,
      'accountDTO': accountDTO!.toJson(),
    };
  }
}

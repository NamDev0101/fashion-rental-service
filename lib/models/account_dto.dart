import 'package:frs_mobile/models/role_model.dart';

class AccountDTO {
  int accountID;
  String password;
  String email;
  String status;
  int reportedCount;
  RoleModel roleDTO;

  AccountDTO({
    required this.accountID,
    required this.password,
    required this.email,
    required this.status,
    required this.reportedCount,
    required this.roleDTO,
  });

  factory AccountDTO.fromJson(Map<dynamic, dynamic> json) {
    return AccountDTO(
      accountID: json['accountID'],
      password: json['password'],
      email: json['email'],
      status: json['status'],
      reportedCount: json['reportedCount'],
      roleDTO: RoleModel.fromJson(json['roleDTO']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'accountID': accountID,
      'password': password,
      'email': email,
      'status': status,
      'reportedCount': reportedCount,
      'roleDTO': roleDTO.toJson(),
    };
  }
}

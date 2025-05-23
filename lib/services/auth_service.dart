import 'package:firebase_auth/firebase_auth.dart';
import 'package:frs_mobile/services/authentication_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  // signInWithGoogle() async {
  //   // mở cửa sổ tương tác là GooogleSignIn().signIn(); để User chọn tài khoản Google và Login.
  //   // gán giá trị thằng GoogleSignInAccount chứa
  //   // thông tin về tài khoản Google của User đã chọn
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //   // Sau khi User đã chọn tài khoản đăng nhập, lấy thông tin xác thực từ request bằng cách
  //   // gọi ‘.authentication’ trên GoogleSignInAccount
  //   // thông tin xác thực bao gồm accessToken và idToken
  //   // sau đó gán thông tin xác thực này cho GoogleSignInAuthentication để có thể truy cập accessToken và idToken

  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //   // tạo credential của GoogleAuthProvider bằng cách truyền vào accessToken và idToken lấy từ bước trên
  //   // credential được sử dụng để xác thực người dùng với FireBase Authentication
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );

  //   // sử dụng credential để đăng nhập vào FirebaseAuthentication bằng cách gọi signInWithCredential
  //   // trả về một User
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('Đăng nhập bằng Google đã bị hủy bỏ.');
      }
      print('googleUser accessToken: ${googleUser.id}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('googleAuth accessToken: ${googleAuth.accessToken}');
      print('googleAuth idToken: ${googleAuth.idToken}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithCredential(credential);

      // // Lấy thông tin user từ UserCredential
      // User? user = userCredential.user;

      Map<String, dynamic>? response =
          await AuthenticationService.checkLoginGoogle(googleAuth.idToken!);

      if (response != null) {
        print('Đăng nhập thành công');
      } else {
        print('Đăng nhập không thành công');
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}

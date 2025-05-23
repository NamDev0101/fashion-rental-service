import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frs_mobile/core/constants/color_constants.dart';
import 'package:frs_mobile/core/constants/dismension_constants.dart';
import 'package:frs_mobile/core/constants/textstyle_constants.dart';
import 'package:frs_mobile/models/feedback_model.dart';
import 'package:frs_mobile/models/productOwner_model.dart';
import 'package:frs_mobile/models/product_detail_model.dart';
import 'package:frs_mobile/models/product_image_model.dart';
import 'package:frs_mobile/models/product_model.dart';
import 'package:frs_mobile/representation/screens/chat_screen.dart';
// import 'package:frs_mobile/representation/screens/customer/customer_main_screen.dart';
import 'package:frs_mobile/representation/screens/product_detail/product_detail_demo.dart';
import 'package:frs_mobile/representation/screens/product_detail/services/api_product_detail.dart';
import 'package:frs_mobile/representation/screens/productowner_screen/services/api_producOwner.dart';
import 'package:frs_mobile/representation/widgets/product_card_demo.dart';
import 'package:frs_mobile/services/authentication_service.dart';
import 'package:frs_mobile/services/authprovider.dart';
import 'package:frs_mobile/utils/dialog_helper.dart';

class ProductOwnerShopScreen extends StatefulWidget {
  final ProductOwnerModel? productOwnerModel;
  const ProductOwnerShopScreen({
    super.key,
    required this.productOwnerModel,
  });
  static const String routeName = '/productOwner_shop_screen';
  @override
  State<ProductOwnerShopScreen> createState() => _ProductOwnerShopScreenState();
}

class _ProductOwnerShopScreenState extends State<ProductOwnerShopScreen> {
  int selectedAllProduct = 0;
  bool isAllProduct = true;
  bool isBuyProduct = false;
  bool isRentProduct = false;

  void onChatButtonPressed() async {
    if (AuthProvider.userModel != null) {
      try {
        final response = await AuthenticationService.getRoom(
            widget.productOwnerModel!.accountDTO!.accountID,
            AuthProvider.userModel!.accountID);
        print(response);
        if (response != null && response.containsKey("roomID")) {
          int roomID = response["roomID"];

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(roomID: roomID),
            ),
          );
          // Navigator.pushReplacementNamed(context, CustomerMainScreen.routeName);
        } else {
          print("Không nhận được roomID từ API getRoom");
        }
      } catch (error) {
        print("Lỗi khi gọi API getRoom: $error");
      }
    } else {
      showCustomDialog(context, "Lỗi", "Vui lòng Đăng nhập vào hệ thống", true);
    }
  }

  Future<List<ProductModel>?> fetchProducts() async {
    switch (selectedAllProduct) {
      case 0:
        return await APIProductOwner.getProductByProductOwnerIDForCus(
            widget.productOwnerModel!.productOwnerID);
      // case 1:
      //   if (selectedCategory != null)
      //     return await AuthenticationService.getAllProductByCategoryName(
      //         selectedCategory!.categoryName);
      // case 2:
      //   return await AuthenticationService.getAllProductOnAvailable();
      // case 3:
      //   return await AuthenticationService.getAllProductOnSoldOut();
      case 4:
        return await APIProductOwner.getProductOnRentByProductOwnerIDForCus(
            widget.productOwnerModel!.productOwnerID);
      case 5:
        return await APIProductOwner.getProductOnSaleByProductOwnerIDForCus(
            widget.productOwnerModel!.productOwnerID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 230,
            color: ColorPalette.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          color: Colors.white,
                          FontAwesomeIcons.angleLeft,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextField(
                            onTap: () {},
                            decoration: InputDecoration(
                              hintText: 'Bạn muốn tìm tên sản phẩm gì?',
                              hintStyle: TextStyles.defaultStyle,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(kTopPadding8),
                                child: Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: ColorPalette.primaryColor,
                                  size: kDefaultIconSize18,
                                ),
                              ),
                              filled: true,
                              fillColor: ColorPalette.hideColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.primaryColor),
                                borderRadius:
                                    BorderRadius.circular(kDefaultCircle14),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.circular(kDefaultCircle14),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kItemPadding10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        color: Colors.white,
                        FontAwesomeIcons.caretDown,
                        size: 22,
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  widget.productOwnerModel!.avatarUrl,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.productOwnerModel!.fullName,
                                  style: TextStyles.h5.bold.whiteTextColor,
                                ),
                                SizedBox(width: 60),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(kDefaultCircle14),
                                  ),
                                  child: GestureDetector(
                                    onTap: onChatButtonPressed,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Chat',
                                        style: TextStyles.h5.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (AuthProvider.userModel != null)
                              Row(
                                children: [
                                  Icon(
                                    size: 14,
                                    FontAwesomeIcons.phone,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.productOwnerModel!.phone,
                                    style:
                                        TextStyles.defaultStyle.whiteTextColor,
                                  ),
                                ],
                              ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${widget.productOwnerModel!.reputationPoint}',
                                  style: TextStyles.defaultStyle.whiteTextColor,
                                ),
                              ],
                            ),
                            if (AuthProvider.userModel != null)
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.locationDot,
                                      size: 14, color: Colors.white),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 249,
                                    child: AutoSizeText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      minFontSize: 14,
                                      widget.productOwnerModel!.address,
                                      style: TextStyles
                                          .defaultStyle.whiteTextColor,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAllProduct = 0;
                        isAllProduct = true;
                        isBuyProduct = false;
                        isRentProduct = false;
                      });
                    },
                    child: Text('Tất cả',
                        style:
                            isAllProduct ? TextStyles.h5.bold : TextStyles.h5)),
                Text('|', style: TextStyles.h5),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAllProduct = 5;
                        isAllProduct = false;
                        isBuyProduct = true;
                        isRentProduct = false;
                      });
                    },
                    child: Text('Mua',
                        style:
                            isBuyProduct ? TextStyles.h5.bold : TextStyles.h5)),
                Text('|', style: TextStyles.h5),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAllProduct = 4;
                        isAllProduct = false;
                        isBuyProduct = false;
                        isRentProduct = true;
                      });
                    },
                    child: Text('Thuê',
                        style: isRentProduct
                            ? TextStyles.h5.bold
                            : TextStyles.h5)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<ProductModel>?>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Lỗi: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<ProductModel> products = snapshot.data ?? [];
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 270,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: ((context, index) {
                          return Transform.translate(
                            offset: Offset(0, index.isOdd ? 0.0 : 0.0),
                            child: GestureDetector(
                              onTap: () async {
                                ProductDetailModel? productDetail =
                                    await AuthenticationService.getProductByID(
                                        products[index].productID);
                                int productOwnerID =
                                    productDetail!.productOwnerID;
                                ProductOwnerModel? productOwnerModel =
                                    await AuthenticationService
                                        .getProductOwnerByID(productOwnerID);
                                List<FeedbackModel> feedbackProduct =
                                    await ApiProductDetail
                                        .getFeedbackByProductID(
                                            products[index].productID);
                                List<ProductImageModel>? productImages =
                                    await AuthenticationService
                                        .getAllProductImgByProductID(
                                            products[index].productID);

                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ProductDetailDemo(
                                      productImageModel: productImages!,
                                      productOwnerModel: productOwnerModel,
                                      productDetailModel: productDetail,
                                      feedbackList: feedbackProduct,
                                    ),
                                  ),
                                );
                                print(products[index].productID);
                              },
                              child: ProductCardDemo(
                                product: products[index],
                                // aspectRatio: aspectRatio,
                              ),
                            ),
                          );
                          // double aspectRatio = index.isEven ? 1.5 : 1.0;
                          // if (index % 2 == 0) {
                          //   return GestureDetector(
                          //     onTap: () {},
                          //     child: ProductCardDemo(
                          //       aspectRatio: aspectRatio,
                          //       product: products[index],
                          //     ),
                          //   );
                          // }
                          // return OverflowBox(
                          //   // maxHeight: 260.0 + 70,
                          //   maxHeight: 400,
                          //   child: GestureDetector(
                          //     onTap: () {},
                          //     child: Container(
                          //       margin: EdgeInsets.only(top: 70),
                          //       child: ProductCardDemo(
                          //         aspectRatio: aspectRatio,
                          //         product: products[index],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }),
                      ),
                    );
                  } else {
                    return Text('Không có dữ liệu sản phẩm');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

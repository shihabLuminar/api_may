import 'package:api_session2/model/pdocuct_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetialsScreenController with ChangeNotifier {
  ProductDetailsModel? selectedProduct;
  bool isLoading = false;

  Future<void> getProductDetails(String productId) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        selectedProduct = sigleDataModelFromJson(res.body);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}

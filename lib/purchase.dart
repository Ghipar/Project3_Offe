import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_3/product.dart';

class Purchase extends GetxController {
  var products = <product>[].obs;
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 1));
    //call from server ends
    var serverResponse = [
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
      product(1, "Demo Product", "aby",
          "This is a Product that we are going to show by getX", 300.0),
    ];
    products.value = serverResponse;
  }
}

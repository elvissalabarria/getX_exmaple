import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:getx_example/models/product.dart';
import 'package:getx_example/services/remote_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var mode = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void changeModeList() async {
    mode.value = !mode.value;
  }
}

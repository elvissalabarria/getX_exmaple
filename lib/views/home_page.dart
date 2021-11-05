import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_example/controllers/productcontroller.dart';
import 'package:getx_example/views/product_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: () {
          return _refresh();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "ShopX",
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  )),
                  IconButton(
                      onPressed: () {
                        productController.mode.value = true;
                      },
                      icon: const Icon(Icons.view_list_rounded)),
                  IconButton(
                      onPressed: () {
                        productController.mode.value = false;
                      },
                      icon: const Icon(Icons.grid_view)),
                ],
              ),
            ),
            Expanded(child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return StaggeredGridView.countBuilder(
                    crossAxisCount: (productController.mode.value) ? 2 : 1,
                    itemCount: productController.productList.length,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return ProductTile(productController.productList[index]);
                    },
                    staggeredTileBuilder: (index) =>
                        const StaggeredTile.fit(1));
              }
            }))
          ],
        ),
      ),
    );
  }

  Future<dynamic> _refresh() async {
    return productController.onInit();
  }
}

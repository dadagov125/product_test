import 'package:flutter/material.dart';
import 'package:product_test/domain/models/product_model.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(
      {super.key, this.controller, required this.products, this.onRemove});

  final ScrollController? controller;
  final List<ProductModel> products;
  final void Function(String)? onRemove;

  Widget buildElement(ProductModel model) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Image(image: NetworkImage(model.imageUrl)),
        Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                onRemove?.call(model.id);
              },
              child: Icon(Icons.delete),
            )),
        Positioned(bottom: -15, left: 0, child: Text(model.name))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      controller: controller,
      padding: EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      children: products.map((p) => buildElement(p)).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:product_test/domain/models/product_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList(
      {super.key, this.controller, required this.products, this.onRemove});

  final ScrollController? controller;
  final List<ProductModel> products;
  final void Function(String)? onRemove;

  Widget buildElement(ProductModel model) {
    return ListTile(
        leading: Container(
          height: 50,
          width: 50,
          child: Image(image: NetworkImage(model.imageUrl)),
        ),
        title: Text(model.name),
        trailing: InkWell(
          onTap: () {
            onRemove?.call(model.id);
          },
          child: Icon(Icons.delete),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.all(10),
      children: products.map((p) => buildElement(p)).toList(),
    );
  }
}

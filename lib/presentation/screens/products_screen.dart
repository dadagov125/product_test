import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_test/domain/states/local/product/product_bloc.dart';

import '../widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen();

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => ProductBloc(),
        child: _ProductsScreenContent(),
      );
}

class _ProductsScreenContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsScreenContentState();
}

class _ProductsScreenContentState extends State<_ProductsScreenContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    final productBloc = context.read<ProductBloc>();
    productBloc.add(LoadProductsEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 100) {
        final state = productBloc.state;
        if (state is ProductLoadingState) return;
        if (!state.hasNext) return;
        productBloc.add(LoadProductsEvent());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ProductsGrid(
            controller: _scrollController,
            products: state.products,
            onRemove: (id) {
              final productBloc = context.read<ProductBloc>();
              productBloc.add(RemoveProductsEvent(id));
            },
          ),
        );
      },
    );
  }
}

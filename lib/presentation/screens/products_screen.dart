import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_test/domain/states/local/product/product_bloc.dart';

import '../../domain/states/local/product_screen/product_screen_bloc.dart';
import '../widgets/products_grid.dart';
import '../widgets/products_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen();

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => ProductBloc(),
        ),
        BlocProvider(
          create: (_) => ProductScreenBloc(),
        ),
      ], child: _ProductsScreenContent());
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

  PreferredSizeWidget buildAppBar(
      BuildContext context, ProductScreenState screenState) {
    return AppBar(
      actions: [
        Container(
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () {
              final productBloc = context.read<ProductBloc>();
              productBloc.add(CreateProductsEvent());
            },
            child: Icon(Icons.add),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () {
              final screenBloc = context.read<ProductScreenBloc>();
              screenBloc.add(ProductScreenSwitch());
            },
            child: Builder(
              builder: (context) {
                if (screenState is ProductScreenGridState)
                  return Icon(Icons.list);
                return Icon(Icons.grid_view);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildBody(BuildContext context, ProductScreenState screenState,
      ProductState productState) {
    if (screenState is ProductScreenListState)
      return ProductsList(
        controller: _scrollController,
        products: productState.products,
        onRemove: (id) {
          final productBloc = context.read<ProductBloc>();
          productBloc.add(RemoveProductsEvent(id));
        },
      );

    return ProductsGrid(
      controller: _scrollController,
      products: productState.products,
      onRemove: (id) {
        final productBloc = context.read<ProductBloc>();
        productBloc.add(RemoveProductsEvent(id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductScreenBloc, ProductScreenState>(
      builder: (context, screenState) {
        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            return Scaffold(
              appBar: buildAppBar(context, screenState),
              body: buildBody(context, screenState, productState),
            );
          },
        );
      },
    );
  }
}

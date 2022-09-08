import 'package:bloc/bloc.dart';

part 'product_screen_event.dart';

part 'product_screen_state.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  ProductScreenBloc() : super(ProductScreenGridState()) {
    on<ProductScreenSwitch>((event, emit) {
      if (state is ProductScreenGridState) {
        emit(ProductScreenListState());
      } else if (state is ProductScreenListState) {
        emit(ProductScreenGridState());
      }
    });
  }
}

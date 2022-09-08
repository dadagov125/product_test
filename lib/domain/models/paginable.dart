class Paginable<T> {
  Paginable({required this.totalCount, required this.items});

  final int totalCount;

  final List<T> items;
}

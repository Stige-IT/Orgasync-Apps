class ResponseData<T>{
  final int? total;
  final T? data;
  final int? currentPage;
  final int? lastPage;

  ResponseData({this.total = 0, this.data, this.currentPage = 0, this.lastPage = 0});
}
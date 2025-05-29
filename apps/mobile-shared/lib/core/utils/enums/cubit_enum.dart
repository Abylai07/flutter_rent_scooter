enum CubitStatus { initial, success, error, loading }

extension CubitStatusX on CubitStatus {
  bool get isInitial => this == CubitStatus.initial;

  bool get isSuccess => this == CubitStatus.success;

  bool get isError => this == CubitStatus.error;

  bool get isLoading => this == CubitStatus.loading;

}
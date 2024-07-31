class ApiControllerResponse {
  final String _message;
  final bool _isSuccess;

  ApiControllerResponse(this._message, this._isSuccess);

  bool get isSuccess => _isSuccess;
  String get message => _message;
}
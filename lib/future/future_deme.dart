class CustomError {
  CustomError(this.id, this.msg);

  int id;

  String msg;

  @override
  String toString() {
    return "id: $id, msg:$msg";
  }
}

enum ERROR { TOKEN_ERROR, ID_ERROR }

void main() {
  Future future = Future((){

    return Future.error(ERROR.TOKEN_ERROR);

  });
  future.then((res) {
    print("then。");
  }).whenComplete(() {
    print("whenComplete");
  }).catchError((e) {
    print("------------");
    print("${e == ERROR.TOKEN_ERROR}");
    print("${e == ERROR.ID_ERROR}");
    print(e);
  });
}

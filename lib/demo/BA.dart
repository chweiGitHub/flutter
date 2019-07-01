


import 'A.dart';
import 'B.dart';
import 'P.dart';

class  BA extends P with B,A{
  printMsg (){
    print("这里输出的是BA类中的内容");
  }
}
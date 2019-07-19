import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-17
/// description 搜索框
class SearchInputView extends StatefulWidget {
  // 初始值
  final String initialValue;

  // 提示文字
  final String hint;

  // 左边的icon
  final Widget leftIcon;

  // 右边的icon
  final Widget rightIcon;

  // 左边的icon是否显示
  final bool leftIconShow;

  // 右边的icon是否显示
  final bool rightIconShow;

  final Function rightIconPress;

  final Function valueChange ;

  const SearchInputView({
    Key key,
    this.initialValue,
    this.hint,
    this.leftIcon,
    this.rightIcon,
    this.leftIconShow = true,
    this.rightIconShow = true, this.rightIconPress, this.valueChange,
  }) : super(key: key);

  @override
  _SearchInputViewState createState() => _SearchInputViewState();
}

class _SearchInputViewState extends State<SearchInputView> {
  TextEditingController _controller;
  String value="";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue != null && widget.initialValue.length > 0) {
      value  = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {

    _controller.text = value;
    _controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: value.length));

    String hint = widget.hint == null ? "请输入要搜索的内容" : widget.hint;
    Widget leftIcon =
        widget.leftIcon == null ? Icon(Icons.search) : widget.leftIcon;
    Widget rightIcon =
        widget.rightIcon == null ? Icon(Icons.close) : widget.rightIcon;

    return Container(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: !widget.leftIconShow,
            child: leftIcon,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              expands: false,
              onChanged: (v) {
                if(widget.valueChange != null){
                  widget.valueChange(v);
                }
                value = v;
              },
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
              onSubmitted: (value) {},
              onEditingComplete: () {},
              autofocus: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 13.0),
                  hintText: hint),
            ),
          ),
          Offstage(
            offstage: !widget.rightIconShow,
            child: GestureDetector(child: rightIcon, onTap: () {
              setState(() {
                value="";
              });
              if(widget.rightIconPress!=null){
                widget.rightIconPress ();
              }
            }),
          ),
        ],
      ),
    );
  }
}

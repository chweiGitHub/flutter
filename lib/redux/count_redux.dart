


// 1. 创建State
class CountState {
  int _count ;
  get count => _count;

  CountState(this._count);

  CountState.initState (){_count = 0;  }

}



// 2. 创建Action
enum Action{
  increment ,
  reduce
}


// 3. 创建reducer
CountState reducer (CountState state, action){
  if(action == Action.increment){
    return CountState(state.count+1);
  } else  if(action == Action.reduce){
    return CountState(state.count-1);
  }
}

// 4. 创建store

// 5. 将store 放入顶层
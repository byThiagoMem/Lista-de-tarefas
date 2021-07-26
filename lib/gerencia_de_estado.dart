import 'shared/models/todo_item.dart';

class GerenciaDeEstado<T> {
  final _toDoItemList = <ToDoItem>[];
  late T _state;
  final _listens = <Function>[];

  GerenciaDeEstado({required T initialState}) {
    _state = initialState;
  }

  // ignore: type_annotate_public_apis
  get toDoItemList => _toDoItemList;
  final _doneItemList = <ToDoItem>[];

  void onAddItem(String itemTitle) {
    toDoItemList.add(
      ToDoItem(
        title: itemTitle,
      ),
    );
    _update();
  }

  void onCompleteItem(ToDoItem item) {
    toDoItemList.remove(item);
    _doneItemList.add(
      ToDoItem(
        title: item.title,
        isDone: true,
      ),
    );
    _update();
  }

  void onRemoveDoneItem(ToDoItem item) {
    _doneItemList.remove(item);
    _update();
  }

  void onRemoveToDoItem(ToDoItem item) {
    toDoItemList.remove(item);
    _update();
  }

  void onResetItem(ToDoItem item) {
    _doneItemList.remove(item);
    toDoItemList.add(
      ToDoItem(
        title: item.title,
      ),
    );
    _update();
  }

  void _update() {
    for (var i = 0; i < _listens.length; i++) {
      _listens[i](_state);
    }
  }

  void listen(void Function(T state) onUpdate) {
    _listens.add(onUpdate);
  }
}

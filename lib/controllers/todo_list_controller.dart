import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/controllers/setting_controller.dart';
import 'package:riverpod_sample/models/todo.dart';

/// riverpod での provider 宣言部分
final todoListProvider = ChangeNotifierProvider<TodoListController>((ref) {
  // 他の provider の値を参照する場合の書き方
  // settingsProvider から通知が来たらその変更を反映する
  // settingsProvider を直接見た方が良いです
  final color = ref.watch(settingsProvider).color;

  return TodoListController._(color: color);
});

class TodoListController extends ChangeNotifier {
  TodoListController._({required this.color});

  /// 文字色を決めるための変数
  final Color color;

  /// リポジトリから todoList を取得する
  /// ページ側ではついでに　FutureBuilder のサンプルも書いています
  Future<List<Todo>> fetchTodoList() async {
    return TodoRepository.instance.fetchTodoList();
  }

  /// ダイアログに入力された内容で[Todo]を追加する
  Future<void> addTodo(BuildContext context) async {
    var description = '';

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(
            cursorColor: color,
            autofocus: true,
            onChanged: (value) => description = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('追加', style: TextStyle(color: color)),
            ),
          ],
        );
      },
    );

    if (result == true && description.isNotEmpty) {
      TodoRepository.instance.add(Todo.create(description: description));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[$description]を追加しました'),
      ));

      notifyListeners();
    }
  }

  /// 指定した[Todo]をリストから取り除く
  void removeTodo(Todo todo) {
    TodoRepository.instance.remove(todo);
    notifyListeners();
  }
}

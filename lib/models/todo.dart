import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class Todo {
  const Todo({
    required this.description,
    required this.createdAt,
    required this.done,
  });

  Todo.create({required this.description})
      : createdAt = DateTime.now(),
        done = false;

  /// [Todo]の説明
  final String description;

  /// [Todo]を生成した時間
  /// Id として活用している
  final DateTime createdAt;

  /// このサンプルでは使用されていない
  final bool done;

  /// これも今回は使用しない
  Todo copyWith({DateTime? createdAt, String? description, bool? done}) {
    return Todo(
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      done: done ?? this.done,
    );
  }
}

class TodoRepository {
  // 簡易的にシングルトンを作る方法
  TodoRepository._();
  static TodoRepository instance = TodoRepository._();

  //// ここにあるデータが全てデータベースにあるイメージです
  final List<Todo> _todoList = [
    Todo.create(description: '掃除'),
    Todo.create(description: '選択'),
    Todo.create(description: 'flutter'),
  ];

  /// [_todoList] を取得する
  /// 擬似的な通信を表現するために、あえて時間のかかる処理にしています
  Future<List<Todo>> fetchTodoList() async {
    // Future.delayed を使うと簡単に○○秒待つといった処理が書ける
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return _todoList;
  }

  /// 指定した[Todo]を追加する
  void add(Todo todo) => _todoList.add(todo);

  /// 指定した[Todo]を削除する
  void remove(Todo todo) => _todoList.remove(todo);
}

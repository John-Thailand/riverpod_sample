import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/controllers/counter_controller.dart';
import 'package:riverpod_sample/views/counter_details_page.dart';

class CounterListPage extends StatelessWidget {
  // ._() でコンストラクタを定義すると気軽に外部から呼べなくなる
  const CounterListPage._();

  // 気軽に外部から呼べないので表示用の static メソッドを用意する
  // そうすると用途を限定できるよという話。
  static void show(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => const CounterListPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => CounterDetailsPage.show(context, index),
              leading: Text('index:$index'),
              title: Consumer(
                builder: (_, widgetRef, __) {
                  // family を使った場合は counterProvider(index) のような形でパラメーターを渡す
                  final count = widgetRef.watch(counterProvider(index)).count;
                  return Text('$count');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:riverpod_sample/views/counter_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => CounterListPage.show(context),
              child: const Text('Counter'),
            ),
            // ElevatedButton(
            //   onPressed: () => TodoListPage.show(context),
            //   child: const Text('TODO'),
            // ),
          ],
        ),
      ),
    );
  }
}

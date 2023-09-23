import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:args/args.dart';
import 'package:todo_app/0_data/repositories/todo_repository_memory.dart';

import 'package:todo_app/0_data/repositories/todo_repository_mock.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/2_application/app/basic_app.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addFlag('mock', abbr: 'm', defaultsTo: false);

  final results = parser.parse(arguments);
  debugPrint('Using the mock repo: ${results['mock']}');
  final mock = results['mock'] as bool;

  runApp(RepositoryProvider<ToDoRepository>(
    create: (context) {
      if (mock) {
        return ToDoRepositoryMock();
      } else {
        return ToDoRespositoryMemory();
      }
    },
    child: const BasicApp(),
  ));
}

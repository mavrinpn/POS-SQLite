import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sqlite/app/app.dart';
import 'package:pos_sqlite/core/error/locator.dart';
import 'package:pos_sqlite/presentation/blocs/app_bloc_observer.dart';
import 'package:pos_sqlite/presentation/blocs/categories/categories_bloc.dart';
import 'package:pos_sqlite/presentation/blocs/items/items_bloc.dart';

const showDebug = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  if (showDebug) {
    Bloc.observer = AppBlocObserver();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (context) =>
              sl<CategoriesBloc>()..add(const LoadCategoriesEvent()),
        ),
        BlocProvider<ItemsBloc>(
          create: (context) => sl<ItemsBloc>(),
        ),
      ],
      child: const App(),
    ),
  );
}

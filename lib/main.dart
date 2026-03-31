import 'package:flutter/material.dart';
import 'package:mvvm_practice/repositories/favorites_repository.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:mvvm_practice/view/splash/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favRepo = FavoritesRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(favRepo)),
        ChangeNotifierProvider(create: (_) => FavoriteViewModel(favRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SplashScreen()),
      ),
    );
  }
}

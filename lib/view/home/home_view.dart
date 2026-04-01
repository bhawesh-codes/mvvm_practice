import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:mvvm_practice/view/home/widgets/book_grid.dart';
import 'package:mvvm_practice/view/home/widgets/pagination_row.dart';
import 'package:mvvm_practice/view/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      builder: (context, _) => Scaffold(
        appBar: MyAppbar(),
        body: Builder(
          builder: (context) {
            if (context.watch<HomeViewModel>().isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              );
            }

            if (context.watch<HomeViewModel>().error != null) {
              return Center(child: Text(context.watch<HomeViewModel>().error!));
            }

            if (context.watch<HomeViewModel>().bookData == null) {
              return const Center(child: Text("No data"));
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: const [
                  BookGrid(), // ✅ extracted
                  SizedBox(height: 12),
                  Divider(),
                  SizedBox(height: 12),
                  PaginationRow(), // ✅ extracted
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

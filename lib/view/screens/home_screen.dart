import 'package:flutter/material.dart';
import 'package:mvvm_practice/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeViewModel>().fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Thuprai"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          if (vm.bookData == null) {
            return Center(child: Text("No data"));
          }

          final books = vm.bookData!.results ?? [];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final book = books[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: book.frontCover != null
                            ? Image.network(
                                book.frontCover!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Container(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      book.title ?? "No title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
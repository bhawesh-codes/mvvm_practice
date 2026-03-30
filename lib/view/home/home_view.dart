import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/const/my_appbar.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replaces initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<HomeViewModel>();
      if (!vm.hasFetched) {
        // ✅ only fetch if not already fetched
        vm.fetchBooks();
      }
    });

    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: MyAppbar(),
      body: Builder(
        builder: (_) {
          if (context.read<HomeViewModel>().isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          if (vm.bookData == null) {
            return const Center(child: Text("No data"));
          }

          final books = vm.bookData!.results ?? [];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(border: Border.all()),
                              child: book.frontCover != null
                                  ? Image.network(
                                      book.frontCover!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Container(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  book.title ?? "No title",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<FavoriteViewmodel>().toggleFavorite(
                                    book,
                                  );
                                },
                                icon: context.watch<FavoriteViewmodel>().isFavorite(book)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (vm.apiService.page != 1)
                      GestureDetector(
                        onTap: () =>
                            context.read<HomeViewModel>().previousPage(),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Previous Page",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 16),
                    if (vm.apiService.page != 5)
                      GestureDetector(
                        onTap: () => context.read<HomeViewModel>().nextPage(),
                        child: const Row(
                          children: [
                            Text(
                              "Next Page",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/const/my_appbar.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({
    super.key,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  final Future<void> Function(Result) toggleFavorite;
  final bool Function(Result) isFavorite;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<FavoriteViewModel>();
      if (!vm.hasLoaded) {
        // ✅ only fetch if not already fetched
        vm.loadFavorites();
      }
    });
    final fvm = context.watch<FavoriteViewModel>();

    if (fvm.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppbar(),
      body: fvm.favoriteBooks.isEmpty
          ? const Center(child: Text("No favorite books"))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fvm.favoriteBooks.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.6,
                        ),
                    itemBuilder: (context, index) {
                      final book = fvm.favoriteBooks[index];

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
                                  onPressed: () async {
                                    await toggleFavorite(
                                      book,
                                    ); // ✅ use passed function
                                    if (context.mounted) {
                                      // ✅ update list smoothly without loading
                                      context
                                          .read<FavoriteViewModel>()
                                          .updateFavorites();
                                    }
                                  },
                                  icon:
                                      isFavorite(book) // ✅ use passed function
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
                ],
              ),
            ),
    );
  }
}

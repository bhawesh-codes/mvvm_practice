import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/const/my_appbar.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key}); 

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteViewModel(),
      builder: (context, child) { if (context.watch<FavoriteViewModel>().isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppbar(),
      body: context.watch<FavoriteViewModel>().favoriteBooks.isEmpty
          ? const Center(child: Text("No favorite books"))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: context.watch<FavoriteViewModel>().favoriteBooks.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.6,
                        ),
                    itemBuilder: (context, index) {
                      final book = context.watch<FavoriteViewModel>().favoriteBooks[index];

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
                                    await context.read<FavoriteViewModel>().toggleFavorite(book); // ✅ own VM
                                  },
                                  icon:
                                      context.watch<FavoriteViewModel>().isFavorite(book) // ✅ own VM
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
    );}
    );
    
  }
}

    
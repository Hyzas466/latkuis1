import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'movie_detail_page.dart';
import 'login_page.dart';

class MovieListPage extends StatefulWidget {
  final String username;

  const MovieListPage({super.key, required this.username});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final Set<String> _bookmarkedMovies = {};

  void _toggleBookmark(String title) {
    setState(() {
      if (_bookmarkedMovies.contains(title)) {
        _bookmarkedMovies.remove(title);
      } else {
        _bookmarkedMovies.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.username}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                final movie = movieList[index];
                final isBookmarked = _bookmarkedMovies.contains(movie.title);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.network(
                      movie.imgUrl,
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.movie, size: 50);
                      },
                    ),
                    title: Text(movie.title),
                    subtitle: Text(
                      '${movie.year} • ${movie.genre}\n⭐ ${movie.rating}',
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: isBookmarked ? Colors.blue : Colors.black54,
                      ),
                      onPressed: () => _toggleBookmark(movie.title),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

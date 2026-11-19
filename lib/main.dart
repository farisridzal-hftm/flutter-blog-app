import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const BlogListPage(),
    );
  }
}

/// Ein einzelner Blog-Eintrag.
class BlogPost {
  final String title;
  final String content;
  final DateTime date;

  const BlogPost({
    required this.title,
    required this.content,
    required this.date,
  });
}

/// Startseite: zeigt eine Liste von Blog-Einträgen.
class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  // Statische Start-Einträge, im State gehalten.
  final List<BlogPost> _posts = [
    BlogPost(
      title: 'Willkommen in meinem Blog',
      content: 'Das ist mein erster Beitrag in der Flutter Blog-App.',
      date: DateTime(2026, 11, 10),
    ),
    BlogPost(
      title: 'Warum Flutter?',
      content: 'Mit einer Codebasis für Android, iOS, Web und Desktop entwickeln.',
      date: DateTime(2026, 11, 14),
    ),
    BlogPost(
      title: 'StatefulWidget vs. StatelessWidget',
      content: 'Ein StatefulWidget kann seinen Zustand ändern und sich neu zeichnen.',
      date: DateTime(2026, 11, 18),
    ),
  ];

  // Vordefinierte Beiträge, die per Button ergänzt werden.
  final List<String> _predefinedTitles = [
    'Hot Reload ist genial',
    'Widgets überall',
    'Mein Lernfortschritt',
  ];

  int _addedCount = 0;

  void _addPost() {
    setState(() {
      final title = _predefinedTitles[_addedCount % _predefinedTitles.length];
      _addedCount++;
      _posts.insert(
        0,
        BlogPost(
          title: title,
          content: 'Automatisch hinzugefügter Beitrag Nr. $_addedCount.',
          date: DateTime.now(),
        ),
      );
    });
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Mein Blog (${_posts.length})'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.article),
              title: Text(post.title),
              subtitle: Text('${_formatDate(post.date)}\n${post.content}'),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPost,
        tooltip: 'Beitrag hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }
}
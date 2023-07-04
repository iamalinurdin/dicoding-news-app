import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/detail_page.dart';
import 'package:news_app/data/model/articles.dart';
import 'package:news_app/utils/result_state.dart';
import 'package:news_app/widgets/card_widget.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {

        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.articles.length,
              itemBuilder: (context, index) {
                var article = state.result.articles[index];

                return CardArticle(article: article);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              )
            );
          } else {
            return const Material(child: Text(''));
          }
        }
      }
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.network(
          article.urlToImage!, 
          width: 100,
          errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
        ),
        title: Text(article.title),
        subtitle: Text(article.description!),
        onTap: () {
          Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: article);
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid, 
      iosBuilder: _buildIos
    );
  }
}
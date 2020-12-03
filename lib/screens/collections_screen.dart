import 'package:cineflex/screens/movie_screen.dart';
import 'package:cineflex/screens/tv_show_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  final String title;
  final Function onLoad;
  final List media;

  const CollectionScreen({
    Key key,
    @required this.title,
    @required this.onLoad,
    this.media,
  }) : super(key: key);
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  ScrollController _scrollController;
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
            page++;
            widget.onLoad(context, page);
          });
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        itemCount: widget.media.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          isLoading = false;
          return GestureDetector(
            onTap: () {
              if (widget.media[index].mediaType == 'movie') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MovieScreen(
                      movie: widget.media[index],
                    ),
                  ),
                );
              } else if (widget.media[index].mediaType == 'tv') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TvShowScreen(
                      tvShow: widget.media[index],
                    ),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.media[index].posterPath == '' ||
                          widget.media[index].posterPath == null
                      ? 'https://dalk4zrp4jp3q.cloudfront.net/images/mac_YFVkNF/movie_placeholder_big_2x.png'
                      : 'https://image.tmdb.org/t/p/w300/${widget.media[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String descriptions;

  DetailScreen({required this.name, required this.imageUrl, required this.descriptions});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Check if scroll position has reached AppBar height
      if (_scrollController.offset > 150 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 150 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: _isScrolled ? Colors.black : Colors.white),
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16),
              centerTitle: true,
              title: Text(
                widget.name,
                style: TextStyle(
                  color: _isScrolled ? Colors.black : Colors.white,
                  fontSize: 20,
                ),
              ),
              background: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      widget.descriptions,
                      style: TextStyle(fontSize: 18.0, height: 1.5),
                    ),
                  )
                ]
                  
               
              ),
            ),
          ),
        ],
      ),
    );
  }
}




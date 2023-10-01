import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sub_space/src/screens/blog_detail_screen.dart';
import 'package:sub_space/src/services/blog_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  void initState() {
    super.initState();
    Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    var blogProvider = Provider.of<BlogProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: 'SUB SPACE'
            .text
            .bold
            .color(Colors.greenAccent)
            .size(20)
            .make()
            .centered(),
        backgroundColor: Colors.black87,
      ),
      body: blogProvider.blogList.isEmpty
          ? const CircularProgressIndicator(color: Colors.green).centered()
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.greenAccent,
              child: ListView.builder(
                itemCount: blogProvider.blogList.length,
                itemBuilder: (context, index) {
                  bool isFavorite = blogProvider.favoriteBlogs.contains(
                    blogProvider.blogList[index]['id'],
                  );
                  return SizedBox(
                    height: 18.h,
                    width: 100.w,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.greenAccent,
                            blurRadius: 5,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(
                            blogProvider.blogList[index]['image_url'],
                          ),
                          radius: 25,
                        ),
                        title: Text(
                          blogProvider.blogList[index]['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 4,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () => blogProvider.isBlogFavorite(
                              blogProvider.blogList[index]['id']),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => BlogDetail(
                              blog: blogProvider.blogList[index],
                            ),
                          ),
                        ),
                      ).p(10),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

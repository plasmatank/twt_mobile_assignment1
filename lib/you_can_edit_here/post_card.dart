import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twt_mobile_assignment1/you_can_edit_here/post.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        
        child: Row(children:[Image.network(widget.post.avatar_path != "" ?
          "https://qnhdpic.twt.edu.cn/download/origin/" + widget.post.avatar_path! :
          "https://login.twt.edu.cn/img/logo.c1bab511.png", width: 100, height: 100,),
          ConstrainedBox(
                constraints:BoxConstraints(
                  maxWidth: 300,
                ),
              child:Column(children: 
          [        
            Text(widget.post.nickname),
            Text(widget.post.title.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,),
            Text(widget.post.content.toString(), maxLines: 3, overflow: TextOverflow.ellipsis,)
          ])
        )
      ]),
        decoration: BoxDecoration(
          border: new Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),       
    );
  }
}

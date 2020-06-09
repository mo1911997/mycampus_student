import 'package:flutter/material.dart';

class PostDetails extends StatefulWidget {
  var index;
  PostDetails(this.index);
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      id = widget.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text("Post Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: <Widget>[

          ],),
          backgroundColor: Colors.blueAccent,
          body: Card(
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.40,
                  child: Padding( 
                    padding: EdgeInsets.all(8.0),
                    child:Hero(
                      
                      child: Image.network("https://picsum.photos/200/300"),
                    tag: 'dash$id',
                    ),
                      
                  )                    
                ),
          ),
          
        ),
    );
  }
}
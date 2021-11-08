
import 'package:flutter/material.dart';
import 'package:pimo/animations/page_transformer.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:provider/provider.dart';

import 'image_item.dart';

class IntroImagePage extends StatefulWidget {
  final int beginIndex;
  final int collectionId;
  final String modelId;
  const IntroImagePage({Key key, this.collectionId, this.beginIndex, this.modelId})
      : super(key: key);

  @override
  _IntroImagePageState createState() => _IntroImagePageState();
}

class _IntroImagePageState extends State<IntroImagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox.fromSize(
            size: const Size.fromHeight(500.0),
            child: FutureBuilder<ImageListViewModel>(
              future: Provider.of<ImageListViewModel>(context, listen: false)
                  .getImageList(widget.collectionId, widget.beginIndex, widget.modelId),
              builder: (context, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else {
                  if (data.error == null) {
                    return Consumer<ImageListViewModel>(
                        builder: (ctx, data, child) => PageTransformer(
                          pageViewBuilder: (context, visibilityResolver) {
                            return PageView.builder(
                              controller: PageController(initialPage: widget.beginIndex, keepPage: true, viewportFraction: 1),
                              itemCount: data.images.length,
                              itemBuilder: (context, index) {
                                var item = data.images.elementAt(index);
                                var pageVisibility = visibilityResolver
                                    .resolvePageVisibility(index);
                                return ImageItemPage(
                                  item: item,
                                  pageVisibility: pageVisibility,
                                );
                              },
                            );
                          },
                        ));
                  } else {
                    return Text('Error');
                  }
                }
              },
            )),
      ),
    );
  }
}
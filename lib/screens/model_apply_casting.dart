import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/utils/casting_card.dart';
import 'package:pimo/viewmodels/casting_list_view_model.dart';
import 'package:provider/provider.dart';

class ModelApplyCastingPage extends StatefulWidget {
  ModelApplyCastingPage({Key key}) : super(key: key);

  @override
  _ModelApplyCastingPageState createState() => _ModelApplyCastingPageState();
}

class _ModelApplyCastingPageState extends State<ModelApplyCastingPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Tới bạn'),
                    Tab(
                      text: 'Từ bạn',
                    )
                  ],
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(0.8),
                ),
                title: Text('Yêu cầu'),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: SizedBox(
                              height: height - 162,
                              child: FutureBuilder<CastingListViewModel>(
                                  future: Provider.of<CastingListViewModel>(context,
                                      listen: false)
                                      .modelApplyCasting(),
                                  builder: (context, data) {
                                    if (data.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(child: CircularProgressIndicator()),
                                        ],
                                      );
                                    } else {
                                      if (data.error == null && false) {
                                        return Consumer<CastingListViewModel>(
                                            builder: (ctx, data, child) =>
                                                CastingListComponent(
                                                  check: true,
                                                  list: data,
                                                ));
                                      } else {
                                        return Center(
                                          child: SizedBox(
                                            child: Text('Chưa có đề nghị nào'),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )
                        ],
                      )),
                  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: SizedBox(
                              height: height - 162,
                              child: FutureBuilder<CastingListViewModel>(
                                  future: Provider.of<CastingListViewModel>(context,
                                      listen: false)
                                      .modelApplyCasting(),
                                  builder: (context, data) {
                                    if (data.connectionState ==
                                        ConnectionState.waiting) {
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
                                        return Consumer<CastingListViewModel>(
                                            builder: (ctx, data, child) =>
                                                CastingListComponent(
                                                  check: true,
                                                  list: data,
                                                ));
                                      } else {
                                        return Center(
                                          child: SizedBox(
                                            child: Text(
                                                'Bạn chưa đăng kí bất kì casting nào !'),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )
                        ],
                      )),
                ],
              )),
        ));
  }
}


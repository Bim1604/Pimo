import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/viewmodels/casting_info_list_view_model.dart';
import 'package:pimo/viewmodels/casting_list_view_model.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/incoming_casting_list_component.dart';
import 'model_schedule.dart';

class IncomingCastingPage extends StatelessWidget {
  const IncomingCastingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Chiến dịch'),
            backgroundColor: MaterialColors.mainColor,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Chiến dịch đã ứng tuyển'),
                Tab(text: 'Chiến dịch đã được duyệt')
              ],
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.8),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  child: Icon(Icons.schedule),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                        create: (_) => TaskListViewModel()),
                                  ],
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return ModelSchedulePage();
                                    },
                                  ))),
                    );
                  },
                ),
              )
            ],
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
                      child: FutureBuilder<CastingInfoListViewModel>(
                          future: Provider.of<CastingInfoListViewModel>(context,
                                  listen: false)
                              .getCastingInfoList(),
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
                                return Consumer<CastingInfoListViewModel>(
                                    builder: (ctx, data, child) =>
                                        IncomingCastingListComponent(
                                          list: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text('Không có lịch đặt'),
                                    ),
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
                      child: FutureBuilder<CastingInfoListViewModel>(
                          future: Provider.of<CastingInfoListViewModel>(context,
                                  listen: false)
                              .getCastingInfoList(),
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
                              if (data.error != null) {
                                return Consumer<CastingInfoListViewModel>(
                                    builder: (ctx, data, child) =>
                                        IncomingCastingListComponent(
                                          list: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text('Có lịch đặt'),
                                    ),
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

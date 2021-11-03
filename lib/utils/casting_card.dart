import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/screens/casting_detail.dart';
import 'package:pimo/viewmodels/casting_list_view_model.dart';
import 'package:pimo/viewmodels/casting_view_model.dart';
import 'package:provider/provider.dart';

class CastingListComponent extends StatefulWidget {
  final CastingListViewModel list;
  final bool check;
  CastingListComponent({Key key, this.list, this.check}) : super(key: key);

  @override
  CastingListComponentState createState() =>  CastingListComponentState();
}

class  CastingListComponentState extends State<CastingListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.castings.length,
      itemBuilder: (context, index) {
        return CastingCard(casting: widget.list.castings[index], check: widget.check);
      },
    );
  }
}

class CastingCard extends StatelessWidget {
  final CastingViewModel casting;
  final bool check;
  const CastingCard({Key key, this.casting, this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CastingListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return CastingDetailPage(
                        isApplyPage: check,
                        casting: casting,
                      );
                    },
                  ))),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: MaterialColors.mainColor.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    casting.name?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Container(
                    child: Text(
                      casting.getStatus?? '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: casting.getStatus == 'Opening'
                            ? Colors.green
                            : casting.getStatus == 'Closed'
                            ? Colors.amberAccent
                            : Colors.grey[800])),
              ],
            ),
            Row(
              children: [
                Text(
                  casting.salary?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            Container(
              child: Text(
                casting.description?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Text('Mở vào lúc: '),
                Text(
                  casting.openDate?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
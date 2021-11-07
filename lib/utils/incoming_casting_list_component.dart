import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/screens/incoming_task_in_casting.dart';
import 'package:pimo/viewmodels/casting_info_list_view_model.dart';
import 'package:pimo/viewmodels/casting_info_view_model.dart';

class IncomingCastingListComponent extends StatefulWidget {
  final CastingInfoListViewModel list;
  IncomingCastingListComponent({Key key, this.list}) : super(key: key);

  @override
  IncomingCastingListComponentState createState() =>
      IncomingCastingListComponentState();
}

class IncomingCastingListComponentState
    extends State<IncomingCastingListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.listCastingInfo.length,
      itemBuilder: (context, index) {
        return CastingCard(casting: widget.list.listCastingInfo[index]);
      },
    );
  }
}

class CastingCard extends StatelessWidget {
  final CastingInfoViewModel casting;
  const CastingCard({Key key, this.casting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    casting.castingDetail.name ?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  casting.castingDetail.salary.toString() + 'VNĐ' ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            Container(
              child: Text(
                casting.castingDetail.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Text('Thời gian: '),
                Text(
                  '${casting.closeTime}' ?? '',
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

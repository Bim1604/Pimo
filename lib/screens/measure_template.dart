import 'package:flutter/material.dart';
import 'package:pimo/screens/update_measure.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pimo/constants/Theme.dart';
class MeasureTemplatePage extends StatefulWidget {
  final int modelId;
  MeasureTemplatePage({Key key, this.modelId}) : super(key: key);
  @override
  _MeasureTemplatePageState createState() => _MeasureTemplatePageState();
}

class _MeasureTemplatePageState extends State<MeasureTemplatePage> {
  List<String> bodyList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MaterialColors.mainColor,
              title: Text('Số đo cá nhân'),
            ),
            body: FutureBuilder<BodyPartListViewModel>(
              future: Provider.of<BodyPartListViewModel>(context, listen: false)
                  .getListBodyPart(),
              builder: (ctx, prevData) {
                if (prevData.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                else {
                  if (prevData.error == null) {
                    return Consumer<BodyPartListViewModel>(
                      builder: (ctx, data, child) => Center(
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 30),
                              itemCount: data.listBodyPart.length,
                              itemBuilder: (context, index) {
                                return CompButton(
                                  temp: data.listBodyPart[index].name,
                                  value: data.listBodyPart[index].quantity.toString(),
                                  measure: data.listBodyPart[index].measure,
                                  // bodyPartId: data.listBodyAttribute[index].id,
                                  // modelId: widget.modelId,
                                );
                              })),
                    );
                  } else {
                    return Text('Lỗi');
                  }
                }
              },
            )));
  }
}

class CompButton extends StatelessWidget {
  final String temp;
  final String value;
  final String measure;
  // final String modelId;
  // final int bodyPartId;
  // const CompButton({Key key, this.temp, this.modelId, this.bodyPartId}) : super(key: key);
  const CompButton({Key key, this.value, this.measure, this.temp}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: MaterialColors.mainColor.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
            // width: 2,
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color(0xFFF0F0F0),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => BodyPartListViewModel()),
                  ],
                  child: UpdateMeasurePage(
                    // bodyPartId: bodyPartId,
                    // modelId: modelId,
                    template: temp,
                  )),
            ));
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  temp
                      + ' - '
                      + ((value.contains("null")) ? 'Không có' : value)
                      + ' ' + measure,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:pimo/constants/Theme.dart';

class ProductSizePicker extends StatefulWidget {
  @override
  _ProductSizePickerState createState() => _ProductSizePickerState();
}

class _ProductSizePickerState extends State<ProductSizePicker> {
  String isSelected = "0";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = "Gợi cảm";
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      decoration: BoxDecoration(
                          color: isSelected == "Gợi cảm"
                              ? MaterialColors.priceColor
                              : Colors.transparent,
                          border: Border(
                            top: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            left: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            right: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            bottom: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                          ),
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(4.0))),
                      child: Center(
                        child: Text("Gợi cảm",
                            style: TextStyle(
                                color: isSelected == "Gợi cảm"
                                    ? MaterialColors.primary
                                    : Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = "Đường phố";
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                          color: isSelected == "Đường phố"
                              ? MaterialColors.priceColor
                              : Colors.transparent,
                          border: Border(
                            top: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            bottom: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                          )),
                      child: Center(
                        child: Text("Đường phố",
                            style: TextStyle(
                                color: isSelected == "Đường phố"
                                    ? MaterialColors.primary
                                    : Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = "Tự Do";
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                          color: isSelected == "Tự Do"
                              ? MaterialColors.priceColor
                              : Colors.transparent,
                          border: Border(
                            top: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            left: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            right: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                            bottom: BorderSide(
                                color: MaterialColors.border, width: 0.5),
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.0))),
                      child: Center(
                        child: Text("Tự Do",
                            style: TextStyle(
                                color: isSelected == "Tự Do"
                                    ? MaterialColors.primary
                                    : Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500)),
                      )),
                ),
              )
            ],
          ),
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = "Tối giản";
                  });
                },
                child: Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: isSelected == "Tối giản"
                            ? MaterialColors.priceColor
                            : Colors.transparent,
                        border: Border(
                          top: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          left: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          right: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          bottom: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4.0))),
                    child: Center(
                      child: Text("Tối giản",
                          style: TextStyle(
                              color: isSelected == "Tối giản"
                                  ? MaterialColors.primary
                                  : Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = "Cổ điển";
                  });
                },
                child: Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        color: isSelected == "Cổ điển"
                            ? MaterialColors.priceColor
                            : Colors.transparent,
                        border: Border(
                          top: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          bottom: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                        )),
                    child: Center(
                      child: Text("Cổ điển",
                          style: TextStyle(
                              color: isSelected == "Cổ điển"
                                  ? MaterialColors.primary
                                  : Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = "Hoang dã";
                  });
                },
                child: Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                        color: isSelected == "Hoang dã"
                            ? MaterialColors.priceColor
                            : Colors.transparent,
                        border: Border(
                          top: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          left: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          right: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                          bottom: BorderSide(
                              color: MaterialColors.border, width: 0.5),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(4.0))),
                    child: Center(
                      child: Text("Hoang dã",
                          style: TextStyle(
                              color: isSelected == "Hoang dã"
                                  ? MaterialColors.primary
                                  : Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            )
          ])
        ],
      ),
    );
  }
}

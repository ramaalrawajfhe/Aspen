
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectedLocationWidget extends StatefulWidget {
  const SelectedLocationWidget({Key? key}) : super(key: key);
  
  @override
  State<SelectedLocationWidget> createState() => _SelectedLocationWidgetState();
}

class _SelectedLocationWidgetState extends State<SelectedLocationWidget>
{
  bool _isExpanded = false;
  String _selectedValue = 'Aspen,USA';
  
   static const List<String> _locationList = [
    'Aspen.USA',
    'Jordan,Amman',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 50.w,
          height: 17.h,
        ),
        Positioned(
          top: 39,
          right: 20,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 140,
                height: 16,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _isExpanded = !_isExpanded;
                  setState(() {});
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xff0858D0),
                      size: 16,
                    ),
                    Text(
                      _selectedValue,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.2575,
                        color: Color(0xff5f5f5f),
                      ),
                    ),
                    Icon(
                      _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                     color: _isExpanded
                      ? Colors.grey
                      : const Color(0xff0858D0),
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
        ),
        if (_isExpanded)
          Positioned(
              top: 65,
              left: 40,
              right: 15,
              child: Container(
                width: 95,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child:  ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  physics: const BouncingScrollPhysics(),
                  children: _locationList
                    .map(
                       (e) => InkWell(
                    onTap:(){
                      _isExpanded = false;
                      _selectedValue = e;
                      setState(() {});
                    },
                       child: Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                          color: _selectedValue == e
                          ? Colors.black
                          : Colors.black,),
                          child:  Row(
                           children: [
                              const SizedBox(
                            width: 5,
                          ),
                               Text(
                              e.toString(),
                              style: TextStyle(
                              fontSize: 14,
                              color: _selectedValue == e
                              ? Colors.black
                              : Colors.black),
                          ),
                          const SizedBox(
                          width: 5,
                          ),
                          if(_selectedValue == e)
                            const Icon(Icons.check,
                               color: Color(0xff0858D0),
                                size: 16,),
                         ],
                         ),
                    ),
                  ),
    )
    .toList(),

                ),
              ),
          ),
      ],
    );
  }
}
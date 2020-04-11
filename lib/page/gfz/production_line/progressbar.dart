import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class ProgressBar extends StatelessWidget {
  final List modelList;
  const ProgressBar({@required this.modelList}) ;
  @override
  
  Widget build(BuildContext context) {
    final _mediaWidth = MediaQuery.of(context).size.width-60;
    final _mediaWW = MediaQuery.of(context).size.width;
     final List list=modelList;
     List<Widget> _lengthList =  <Widget>[];
     var today = DateTime.now();
     String dateStr = formatDate(today, [yyyy, '-', mm, '-',dd]);
     for (var i = 0; i < list.length; i++) {
       Color a ;
        if (i>0) 
        {
        if (int.parse(list[i-1]['flag'])==0) {
          a = Colors.red;
        }else if(int.parse(list[i-1]['flag'])==1){
           a = Colors.green;
        }
        DateTime time = (DateTime.parse(dateStr+' '+list[i-1]['opt_time']));
        var viewlength = time.hour*60*60+time.minute*60+time.second;
        DateTime time2 = (DateTime.parse(dateStr+' '+list[i]['opt_time']));
        var viewlength2 = time2.hour*60*60+time2.minute*60+time2.second;
        var interval = viewlength2-viewlength;
        var ww = interval*_mediaWidth/24/60/60;
        _lengthList.add(_progressline(ww, a));
        }
     }
     Color startTimeColor;
     Color endTimeColor;
     if (int.parse(list[0]['flag'])==0) {
       startTimeColor = Colors.red;
     }else{
       startTimeColor = Colors.green;
     }
     if (int.parse(list[list.length-1]['flag'])==0) {
       endTimeColor = Colors.red;
     }else{
       endTimeColor = Colors.green;
     }
     _lengthList.add(Text(list[list.length-1]['opt_time'],style: TextStyle(fontSize:12,color: endTimeColor),));
    return Container(
      child: Column(
        children:[
         Container(child:Text(list[0]['line_no']) ,padding: EdgeInsets.only(bottom:5,left:0 ,right: _mediaWW-80),),
        Row(children:_lengthList),
        Container(child: Text(list[0]['opt_time'],style: TextStyle(fontSize:12,color: startTimeColor),),padding: EdgeInsets.only(right:_mediaWW-70),),
        ]
      )
    );
  }
  Widget _progressline(width,lineColor){
    return Container(
      width:width ,
      height: 4,
      color: lineColor,
    );
  }

  

}
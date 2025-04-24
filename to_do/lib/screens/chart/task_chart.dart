

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/main.dart';
import 'package:to_do/provider/task_summary_provider.dart';
import 'package:to_do/widget/kapp_bar.dart';

class TaskChart extends StatelessWidget {

  final TaskSummaryProvider provider;
  const TaskChart({super.key,required this.provider});


  Row chartLabel(String txt,Gradient color,{Widget ? otherPrefix}) => Row(
    children: [
      Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: color,
          borderRadius: BorderRadius.circular(8)
        ),
      ),
      Text(txt,style: TextStyle(
        fontSize: 16,
      ),),
      Expanded(child: Container()),
      if(otherPrefix != null) otherPrefix
    ],
  );


  List<FlSpot> getFakeSpot() {
    List<FlSpot> data = [
       // Day 1: 4 tasks completed
      FlSpot(0, 4), // Day 1
      // Day 2: 2 tasks completed
      FlSpot(1, 2), // Day 2
      // Day 3: 5 tasks completed
      FlSpot(2, 5), // Day 3
      // Day 4: 3 tasks completed
      FlSpot(3, 3), // Day 4
      // Day 5: 6 tasks completed
      FlSpot(4, 6), // Day 5
      // Day 6: 1 task completed
      FlSpot(5, 1), // Day 6
      // Day 7: 0 tasks completed
      FlSpot(6, 0), // Day 7
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: provider..initSummary(),
      child: Scaffold(
        appBar: KappBar(
          strTitle: "Task Progress",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today Progress",style: TextStyle(
                      fontSize: 18,
                    ),),
                    IconButton(
                      onPressed: (){}, 
                      icon: Icon(Icons.date_range,color: Colors.grey,)
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                
                //1.Total Tasks: Number
                //In Chart Show this data
                //1.Pending Task  --RED
                //2.In Progress --Blue
                //3.Completed  --Green
                //4.Overdue --Dark
                if(
                  provider.currantSummary.pendingTask != null //&&
                  // provider.currantSummary.progressTask != null &&
                  // provider.currantSummary.completedTask != null &&
                  // provider.currantSummary.overdueTask != null &&
                  // provider.currantSummary.totalTask != null
                ) Container(
                  width: maxW,
                  height: 200,
                  decoration: BoxDecoration(
                    // color: Colors.grey
                  ),
                  child: PieChart(PieChartData(
                    titleSunbeamLayout: true,
                    sections: [
                      PieChartSectionData(
                        value: (provider.currantSummary.pendingTask! / provider.currantSummary.totalTask!)*100,
                        gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.redAccent,
                        ]),
                        titleStyle: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      PieChartSectionData(
                        value: (provider.currantSummary.progressTask! / provider.currantSummary.totalTask!)*100,
                        titleStyle: TextStyle(
                          color: Colors.white
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.blue,
                          Colors.blueAccent,
                          Colors.lightBlue,
                          Colors.lightBlueAccent,
                        ])
                      ),
                      PieChartSectionData(
                        value: (provider.currantSummary.completedTask! / provider.currantSummary.totalTask!)*100,
                        gradient: LinearGradient(colors: [
                          Colors.green,
                          Colors.greenAccent,
                          // Colors.lightGreen,
                          // Colors.lightGreenAccent,
                        ]),
                        titleStyle: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      PieChartSectionData(
                        value: (provider.currantSummary.overdueTask! / provider.currantSummary.totalTask!)*100,
                        gradient: LinearGradient(colors: [
                          Colors.black45,
                          Colors.black54,
                        ]),
                        titleStyle: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  )),
                )

                else 
                  Container(
                    width: maxW,
                    height: 200,
                    decoration: BoxDecoration(),
                    child: PieChart(PieChartData(
                      titleSunbeamLayout: true,
                      sections: [
                        PieChartSectionData(
                          value: 4/10*100,
                          showTitle: false,
                          gradient: LinearGradient(colors: [
                            Colors.grey,
                            Colors.grey,
                          ]),
                          titleStyle: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ]
                    )),
                  ),
             
                const SizedBox(height: 30,),
                
                //Today Task Total or Selected Date Total Task
                Consumer<TaskSummaryProvider>(
                  builder: (context,pvd,child) {
                    
                    return Card(
                      elevation: 10,
                      color: Colors.grey.shade100,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Today's Total Task",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),),
                            Text(pvd.currantSummary.totalTask?.toString() ?? " 0",style: TextStyle(
                              fontSize: 15,
                              color: Colors.green
                            ),)
                          ],
                        ),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 10,),
          
                // //Chart Label 
                Card(
                  elevation: 10,
                  color: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Column(
                      children: [
                        
                        chartLabel("Pending Task", LinearGradient(colors: [
                          Colors.red,
                          Colors.redAccent,
                        ]),otherPrefix: Text(provider.currantSummary.pendingTask?.toString()??"0")),
                        const SizedBox(height: 10,),
                        chartLabel("In Progress Task", LinearGradient(colors: [
                          Colors.blue,
                          Colors.blueAccent,
                          Colors.lightBlue,
                          Colors.lightBlueAccent,
                        ]),otherPrefix: Text(provider.currantSummary.progressTask?.toString()??"0")),
                        const SizedBox(height: 10,),
                        chartLabel("Completed Task", LinearGradient(colors: [
                          Colors.green,
                          Colors.greenAccent,
                        ]),otherPrefix: Text(provider.currantSummary.completedTask?.toString()??"0")),
                        const SizedBox(height: 10,),
                        chartLabel("Overdue Task", LinearGradient(colors: [
                          Colors.black45,
                          Colors.black54,
                        ]),otherPrefix: Text(provider.currantSummary.overdueTask?.toString()??"0")),
          
          
                      ],
                    ),
                  ),
                ),
          
          
                const SizedBox(height: 30,),
          
                Row(
                  children: [
                    Text("Task Chart",style: TextStyle(
                      fontSize: 18,
                    ),),
                  ],
                ),
          
                const SizedBox(height: 30,),
          
                // //This Box For show Chart OF Task like Stock market
                Container(
                  // width: maxW,
                  height: 300,
                  // color: Colors.grey,/
                  child: LineChart(LineChartData(
      
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            
                            return Text("Day ${value.toInt()+1}");
                          },
                          // getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      // topTitles: AxisTitles(drawBelowEverything: false)
                    ),
                    borderData: FlBorderData(show: false),
      
                    //Showing Grid  
                    gridData: FlGridData(
                      show: false,
                      drawVerticalLine: true,
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.green,
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Colors.greenAccent,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: getFakeSpot(),
                        isCurved: true,
                        gradient: LinearGradient(colors: [
                          Colors.blue,
                          Colors.blueAccent,
                          Colors.lightBlue,
                          Colors.lightBlueAccent,
                        ]),
                        dotData: FlDotData(show: false),
                        barWidth: 5,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(colors: [
                            Colors.blue.withValues(alpha: 0.4),
                            Colors.blueAccent.withValues(alpha: 0.6),
                          ])
                        )
                      )
                    ],
                  )),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
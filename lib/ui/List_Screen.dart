import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import '../constants/Colors.dart';
import '../models/Quote_Model.dart';
import '../view_model/Quote_viewModel.dart';
import '../view_model/Task_View_model.dart';
import '../widget/Card_Widget.dart';
import '../widget/button_widget.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final providerquote = Provider.of<Quote_ViewModel>(context).quotes;
    final random = Random();

    final randomQuote = providerquote.isNotEmpty
        ? providerquote[Random().nextInt(providerquote.length)]
        : QuoteModel();

    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.Darkcolor,
        title: Text(
          'Task List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading:
        Consumer<TaskViewModel>(builder: (context, taskProvider, child) {
          final tasklength = taskProvider.duetask.length;

          return Icon(
            tasklength > 0 ? Icons.list_alt : Icons.sentiment_satisfied,
            color: tasklength > 0 ? Colors.red : Colors.green.shade500,
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CardWidget(quote: randomQuote),
              SizedBox(height: 20),
              Consumer<TaskViewModel>(builder: (context, taskProvider, child) {
                final taskdata = taskProvider.filtertask;
                final tasklength = taskProvider.filtertask.length;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterButton(
                          title: 'All',
                          isSelected: taskProvider.currentfilter == 'All',
                          onTap: () => taskProvider.changefilter('All'),
                        ),
                        FilterButton(
                          title: 'Completed',
                          isSelected: taskProvider.currentfilter == 'Completed',
                          onTap: () => taskProvider.changefilter('Completed'),
                        ),
                        FilterButton(
                          title: 'Pending',
                          isSelected:
                          taskProvider.currentfilter == 'Incomplete',
                          onTap: () => taskProvider.changefilter('Incomplete'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    tasklength > 0
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tasklength,
                      itemBuilder: (context, index) {
                        var task = taskdata[index];
                        return Card(
                          color: AppColors.cardDarkcolor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                task.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    taskProvider.setcompleted(task);
                                  },
                                  icon: Icon(
                                    task.iscompleted
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    taskProvider.removeTask(task);
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Text(
                        'No tasks found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

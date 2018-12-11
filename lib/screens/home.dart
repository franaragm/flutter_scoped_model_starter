import 'package:flutter/material.dart';

import '../ui/app/app_drawer.dart';
import '../ui/containers/date_view.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data/models/task/model.dart';

class HomePage extends StatelessWidget {
  final TaskModel model;
  HomePage({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: AppDrawer(),
      body: ScopedModel<TaskModel>(
        model: model,
        child: _DateView(),
      ),
    );
  }
}

class _DateView extends StatefulWidget {
  @override
  __DateViewState createState() => __DateViewState();
}

class __DateViewState extends State<_DateView> {
  void _onDateChange(DateTime value) {}

  Widget _buildListView(BuildContext context, {TaskModel model}) {
    if (model.date == null) model.today();

    if (!model.isLoaded || model?.tasks == null) {
      model.loadTasks(context);
      return Center(child: CircularProgressIndicator());
    }

    if (model?.tasks != null && model.tasks.isEmpty) {
      return Text("No Items Found");
    }

    return ListView.builder(
      itemCount: model?.tasks?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var _item = model?.tasks[index];
        return Text(_item?.leadTaskTitle);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<TaskModel>(context, rebuildOnChange: true);
    return SingleChildScrollView(
      child: Container(
          // height: 400.0,
          // padding:  EdgeInsets.all(5.0),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DateViewWidget(
            date: _model?.date,
            dateChanged: _onDateChange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildListView(context, model: _model),
            ],
          ),
        ],
      )),
    );
  }
}

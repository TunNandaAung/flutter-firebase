import 'package:firebase_integrations/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:firebase_integrations/todo/model/extra_action.dart';
import 'package:firebase_integrations/utils/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          bool allComplete = state.todos.every((todo) => todo.complete);
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: PopupMenuButton<ExtraAction>(
              icon: Icon(
                CustomIcons.option,
                color: Theme.of(context).dividerColor,
                size: 9,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Theme.of(context).popupMenuTheme.color,
              onSelected: (action) {
                switch (action) {
                  case ExtraAction.clearCompleted:
                    BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                    break;
                  case ExtraAction.toggleAllComplete:
                    BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuItem<ExtraAction>>[
                PopupMenuItem<ExtraAction>(
                  value: ExtraAction.toggleAllComplete,
                  child: Text(
                      allComplete ? 'Mark all incomplete' : 'Mark all complete',
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          color: Theme.of(context).dividerColor)),
                ),
                PopupMenuItem<ExtraAction>(
                  value: ExtraAction.clearCompleted,
                  child: Text('Clear completed',
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          color: Theme.of(context).dividerColor)),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';

class PickValueList {

  Future<String?> pick(BuildContext context, {required List<String> list, String? selected, String? title}) async {
    String? result;
    await showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          title: Text(title ?? "Selecione"),
          children: list.map((e)=>
            ListTile(
              onTap: (){
                result = e;
                Navigator.pop(context);
              },
              selected: selected == null ? false : selected == e,
              title: Text(e),
              //trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ).toList(),
        );
      }
    );
    return result;
  }

}
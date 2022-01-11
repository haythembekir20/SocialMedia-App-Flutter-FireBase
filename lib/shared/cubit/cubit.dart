// ignore_for_file: unused_import, non_constant_identifier_names, dead_code

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Appcubit extends Cubit<Appstates> {
  Appcubit() : super(Appinitialstate());

  static Appcubit get(context) => BlocProvider.of(context);
  late Database database;

 var isDark = false;
  void darkmodetoggle({bool? fromshared}) async {
    if (fromshared != null)
      isDark = fromshared;
    else
      isDark = !isDark;
    CashHelper.savedata(key: 'isDark', value: isDark).then((value) {
      emit(Darkmodetogglestate());
      print('the is dark is $isDark');
       print('the is dark is ${CashHelper.getdata(key: 'isDark')}');
    });
  }
}

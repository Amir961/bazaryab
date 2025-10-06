import 'package:flutter/material.dart' show EdgeInsets;


const kPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

//const myToken= "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC1hcGkucmFoa28uaXIvZ3JhcGhxbCIsImlhdCI6MTc1Mzg2MDczNiwiZXhwIjoxNzU2NDUyNzM2LCJuYmYiOjE3NTM4NjA3MzYsImp0aSI6ImM5R2pQdU9yaWVROWtnYWgiLCJzdWIiOiJhNzJlNzFkMC02NmYzLTExZjAtOTQ2Ni0zZmM0MmFkZmQyYmMiLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.NucppDvA6TmjkGRl-90wN-CqWNZpXLeuWQ1-bBs__As";
//const myToken= "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBwLWFwaS5sb2NhbC9ncmFwaHFsL2F1dGgiLCJpYXQiOjE3NTM3MTA2OTksImV4cCI6MTc1NjMwMjY5OSwibmJmIjoxNzUzNzEwNjk5LCJqdGkiOiIxWURJSzVNTnFGbUlodThDIiwic3ViIjoiOWU5MTcyZDAtNmJiOC0xMWYwLWE0ZGQtZjk0ZWJjNTA0MjRhIiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.FmuMt52qdrsR6U_M8-mkHAxcyavroMTBFl1P4mVErGc";
//const myToken= "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC1hcGkucmFoa28uaXIvZ3JhcGhxbCIsImlhdCI6MTc1Mzk1MTY1NiwiZXhwIjoxNzU2NTQzNjU2LCJuYmYiOjE3NTM5NTE2NTYsImp0aSI6ImVSd3pyQW9rOE5ZcWxUV20iLCJzdWIiOiJiYzcxYTFkMC02YmI4LTExZjAtOWE2Mi1iYmRlNmNiOGM0MWUiLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.13FGp8F-jmgrarE2x4Iu7IZWMevg4LlHsJ5H_nk45eA";
String userToken= "";
const String errorTimeOut= 'اتصال شما به شبکه ضعیف است لطفا دوباره تلاش کنید';
const int qualityDefault=20;

const int timerReload=30;

const int versionApp=6;

const kRadius = 4.0;

// final kStartingDate = Jalali(1300);
// final kEndingDate = Jalali(1406);

enum DatePickerView {
  year,
  month,
  day,
}

const monthNames = [
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];

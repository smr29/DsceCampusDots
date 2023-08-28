import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(
  //hintStyle: TextStyle(color: Colors.black45),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
);

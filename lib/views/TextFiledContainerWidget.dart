import 'package:flutter/material.dart';



class TextFieldContainerWidget extends StatelessWidget{
  final TextEditingController? controller ;
  final IconData? prefixIcon ;
  final TextInputType?keyboardType ;
  final String?hintText ;
  final Color?color ;
  final double?borderRadius ;
  final VoidCallback iconClickEvent;



  const TextFieldContainerWidget({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.borderRadius=10,
    this.hintText,this.keyboardType,
  this.color,
     required this.iconClickEvent(),

});






    @override
    Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
margin: EdgeInsets.all(10),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            boxShadow:[
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0,0.50)
              )],),
          child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: InkWell(child: Icon(prefixIcon),onTap: iconClickEvent,),
                hintText: hintText,


                hintStyle: TextStyle(color: Colors.grey),
              ))
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:to_do/models/actions.dart';
import 'package:to_do/widget/kapp_bar.dart';
import 'package:to_do/widget/setting_button.dart';

class ThemePage extends StatelessWidget {
  
  const ThemePage({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: KappBar(
        strTitle: "Customization",
        showLeading: true,
      ),
      body: Column(
        children: [
          
          SettingButton(
            action: CallBackActions(
              onTap: (){

                showDialog(
                  context: context, 
                  builder: (context) {
                    
                    return AlertDialog(
                      title: const Text("Pick Color"),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color(0xff443a49), 
                          onColorChanged: (value) {
                            
                          },
                        ),
                      ),
                    );
                  },
                );

              }
            ),
            btnTitle: "App Color",
            btnDescr: "color seed from scaffold",
            prefix: Icon(Icons.color_lens_rounded),
            suffix: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.amber
              ),
            ),
          )

        ],
      ),
    );
  }
}
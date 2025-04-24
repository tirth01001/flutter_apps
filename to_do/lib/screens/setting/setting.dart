

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:to_do/models/actions.dart';
import 'package:to_do/screens/setting/pages/theme_page.dart';
import 'package:to_do/widget/kapp_bar.dart';
import 'package:to_do/widget/setting_button.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: KappBar(
        strTitle: "Setting",
      ),
      body: Column(
        children: [

          SettingButton(
            action: CallBackActions(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ThemePage()))
            ),
            btnTitle: "Theme",
            btnDescr: "this button imporve",
            prefix: IconButton.filled(onPressed: (){}, icon: Icon(Icons.color_lens)),
          ),


          SettingButton(
            btnTitle: "Font",
            btnDescr: "this button imporve",
            prefix: IconButton.filled(onPressed: (){}, icon: Icon(Icons.font_download)),
          ),


          SettingButton(
            btnTitle: "About",
            btnDescr: "this button imporve",
            prefix: IconButton.filled(
              onPressed: (){}, 
              icon: Icon(IconlyLight.info_circle),
            ),
          ),

          // SettingButton(
          //   btnTitle: "Theme",
          //   btnDescr: "this button imporve",
          // ),

          // SettingButton(
          //   btnTitle: "Theme",
          //   btnDescr: "this button imporve",
          // ),

        ],
      ),
    );
  }
}
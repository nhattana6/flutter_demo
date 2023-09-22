import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/utils/preferences.dart' as preferences;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _value = true;
  bool _isShowNameInput = false;
  final nameInputController = TextEditingController(text: preferences.username ?? '');
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  final ButtonStyle logoutButtonStyle =
  ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    elevation: 0,
    textStyle: const TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(width: 1, color: Color(0xFF7C7C7C),style: BorderStyle.solid),
    ),
    minimumSize: const Size.fromHeight(50),
  );

  void onChangeName()
  {
    setState(() {
      _isShowNameInput = true;
    });
    myFocusNode.requestFocus();
  }

  void onSubmitChangeName()
  {
    preferences.username = nameInputController.text;
    setState(() {
      _isShowNameInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60, // Image radius
                      backgroundImage: AssetImage('assets/card_image.png'),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Ink(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD7D7D7).withOpacity(0.2),
                                    spreadRadius: 1,
                                    offset: const Offset(2, 3),
                                  ),
                                ]
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                              },
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    if(_isShowNameInput) ...[
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: nameInputController,
                          focusNode: myFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'Enter Name',
                            contentPadding: EdgeInsets.only(bottom: 5),
                            isDense: true,
                          ),
                        ),
                      ),
                      IconButton(onPressed: onSubmitChangeName, icon: const Icon(Icons.done), iconSize: 12,),
                    ] else ...[
                      Text(nameInputController.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      IconButton(onPressed: onChangeName, icon: const Icon(Icons.edit), iconSize: 16,),
                    ]
                  ],
                ),
                const Text('info@youremail.com', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            )
          ]
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 15),
          child: Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        ),
        Container(
          color: const Color(0xFFFBFBFB),
          child: const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Primary City'),
                Text('Barcelona')
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          color: const Color(0xFFFBFBFB),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Copy Event to calendar'),
                CupertinoSwitch(
                  activeColor: const Color(0xFF32D74B),
                  value: _value,
                  onChanged: (v) => setState(() => _value = v),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          color: const Color(0xFFFBFBFB),
          child: const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Manage Events'),
                Icon(Icons.arrow_forward_ios, size: 16,)
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          color: const Color(0xFFFBFBFB),
          child: const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Manage Log in options'),
                Icon(Icons.arrow_forward_ios, size: 16,)
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          color: const Color(0xFFFBFBFB),
          child: const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account Settings'),
                Icon(Icons.arrow_forward_ios, size: 16,)
              ],
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: ElevatedButton(
            onPressed: () => {},
            style: logoutButtonStyle,
            child: const Text('Logout', style: TextStyle(color: Color(0xFF7C7C7C), fontSize: 16, fontWeight: FontWeight.w500),),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:muitsu_arked/primary_btn.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              // height: 160,
              width: size.width * 0.5,
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 12),
                    child: Text(
                      'Quit Arked ?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Are you sure you want to quit?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryButton(
                          title: 'Cancel',
                          width: size.width * 0.2,
                          bgColor: Colors.grey.shade300,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 10),
                        PrimaryButton(
                          title: 'Yep!',
                          width: size.width * 0.2,
                          bgColor: Colors.redAccent,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

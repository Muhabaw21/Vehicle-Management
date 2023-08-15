import 'package:flutter/material.dart';

class ContainerDetailsScreen extends StatelessWidget {
  final int ?containerIndex;
  final Function  ?  onGoBack;

  ContainerDetailsScreen({this.containerIndex, this.onGoBack, required Null Function(dynamic index) onContainerTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Container $containerIndex Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onGoBack!  (),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

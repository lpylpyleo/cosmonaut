import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SquareTab extends StatefulWidget {
  const SquareTab({Key? key}) : super(key: key);

  @override
  _SquareTabState createState() => _SquareTabState();
}

class _SquareTabState extends State<SquareTab> {
  List posts = [];
  
  @override
  void initState() {
    super.initState();
    Supabase.instance.client.rpc('get_latest_posts').execute().then((value) {
      print(value.error?.message);
      print(value.data);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AText('text') ,
            ],
          ),
        );
      },
    );
  }
}

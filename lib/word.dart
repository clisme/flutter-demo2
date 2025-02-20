import 'dart:io';
import 'package:docx_template/docx_template.dart';

void main() async {
  const content = '''
padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product['price']!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        },
        staggeredTileBuilder: (index) => index == _products.length
            ? StaggeredTile.fit(4) // 确保加载指示器占据整个宽度
            : StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  FullScreenImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
''';

  final docx =
      await DocxTemplate.fromBytes(File('template.docx').readAsBytesSync());

  Content c = Content();
  c.add(TextContent("code", content));

  final  d = await docx.generate(c);
  final of = File('output.docx');
  of.writeAsBytesSync(d!);
}

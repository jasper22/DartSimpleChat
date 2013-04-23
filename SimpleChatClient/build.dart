import 'dart:io';
import 'package:web_ui/component_build.dart';

// Ref: http://www.dartlang.org/articles/dart-web-components/tools.html
main()
{
  var args = new List.from(new Options().arguments);
//  args.addAll(['--', '--no-rewrite-urls']);

  build(args, ['web/index.html']);

//  Future dwc = build(args, ['web/index.html'']);

//  dwc
//    .then((_) => Process.run('cp', ['packages/browser/dart.js', 'web/out/dart.js']))
//    .then((_) => Process.run('cp', ['App.css', 'out']));
}

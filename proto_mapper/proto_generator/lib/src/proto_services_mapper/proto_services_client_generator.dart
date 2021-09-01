import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'method_descriptor.dart';

class ProtoServicesClientGenerator
    extends GeneratorForAnnotation<MapProtoServices> {
  final BuilderOptions options;
  late String _prefix;

  ProtoServicesClientGenerator(this.options) {
    var config = options.config;
    _prefix = config['prefix'] as String? ?? 'G';
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    var annotation = _hydrateAnnotation(reader, prefix: _prefix);

    final classElement = element.asClassElement();
    var methodDescriptors = _getMethodDescriptors(classElement, annotation);

    var ret = _generateForClass(
      classElement,
      methodDescriptors,
    );

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    Iterable<MethodDescriptor> methodDescriptors,
  ) {
    final methodBuffer = StringBuffer();

    for (var methodDescriptor in methodDescriptors) {
      final methodName = methodDescriptor.name;
      if (!methodDescriptor.returnTypeIsFuture) {
        // we can't know how to implement sync methods
        continue;
      }

      final pType = methodDescriptor.parameterType.finalType;
      final pName = methodDescriptor.parameterName;
      final rType = methodDescriptor.returnParameterType;
      final rLine = !methodDescriptor.returnType.isList
          ? '''final result = _result.to$rType();'''
          : '''final result = _result.items.map((a) => a.to${(rType as ParameterizedType).typeArguments.first}()).toList();''';

      methodBuffer.writeln('''

  @override
  Future<$rType> $methodName($pType $pName) async {
    final serviceClient = await get${_prefix}ServiceClient();
    final _$pName = $pName.toProto();
    final _result = (await serviceClient.$methodName(_$pName));
    $rLine
    return result;
  }

 
''');
    }

    final className = classElement.name;
    final serviceClassName = (className.endsWith('Base')
        ? className.substring(0, className.length - 'Base'.length)
        : className.endsWith('Interface')
            ? className.substring(0, className.length - 'Interface'.length)
            : className);

    var ret = '''

abstract class ${serviceClassName}ClientBase implements $className {
  Future<$_prefix${serviceClassName}Client> get${_prefix}ServiceClient();

  $methodBuffer
}

''';

    return ret;
  }
}

Iterable<MethodDescriptor> _getMethodDescriptors(
  ClassElement classElement,
  MapProtoServices annotation,
) {
  final methods = classElement.getSortedMethods();
  final methodDescriptors = methods
      .map((fieldElement) => MethodDescriptor.fromMethodElement(
            classElement,
            fieldElement,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return methodDescriptors;
}

MapProtoServices _hydrateAnnotation(ConstantReader reader,
    {String prefix = ''}) {
  var ret = MapProtoServices(
    prefix: reader.read('prefix').literalValue as String? ?? prefix,
  );

  return ret;
}

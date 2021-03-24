import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'defaults_provider_generator_base.dart';

class DefaultsProviderGenerator
    extends DefaultsProviderGeneratorBase<DefaultsProvider> {
  @override
  DefaultsProvider hydrateAnnotation(ConstantReader reader) {
    var defaultsProvider = DefaultsProvider(
      createDefaultsProviderBaseClass:
          reader.read('createDefaultsProviderBaseClass').literalValue as bool ??
              false,
    );
    return defaultsProvider;
  }
}

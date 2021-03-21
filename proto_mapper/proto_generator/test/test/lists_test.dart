import 'package:decimal/decimal.dart';
import 'package:proto_generator_test/src/appliance_type.dart';
import 'package:proto_generator_test/src/lists_host.dart';
import 'package:test/test.dart';

void main() {
  group('Lists', () {
    test('non-nullable lists', () {
      final listshost = _listsHost();

      final proto = listshost.toProto();
      final listshosts2 = proto.toListsHost();

      expect(listshosts2.vapplianceTypes, listshost.vapplianceTypes);
      expect(listshosts2.vbools, listshost.vbools);
      expect(listshosts2.vdatetimes, listshost.vdatetimes);
      expect(listshosts2.vdecimals, listshost.vdecimals);
      expect(listshosts2.vdoubles, listshost.vdoubles);
      expect(listshosts2.vdurations, listshost.vdurations);
      expect(listshosts2.vints, listshost.vints);
      expect(listshosts2.vstrings, listshost.vstrings);
    });
    test('null lists', () {
      final listshost = _listsHost(false);

      final proto = listshost.toProto();
      final listshosts2 = proto.toListsHost();

      expect(listshosts2.nvapplianceTypes, null);
      expect(listshosts2.nvbools, null);
      expect(listshosts2.nvdatetimes, null);
      expect(listshosts2.nvdecimals, null);
      expect(listshosts2.nvdoubles, null);
      expect(listshosts2.nvdurations, null);
      expect(listshosts2.nvints, null);
      expect(listshosts2.nvstrings, null);
    });

    test('nullable lists with values', () {
      final listshost = _listsHost(true);

      final proto = listshost.toProto();
      final listshosts2 = proto.toListsHost();

      expect(listshosts2.nvapplianceTypes, isNotNull);
      expect(listshosts2.nvbools, isNotNull);
      expect(listshosts2.nvdatetimes, isNotNull);
      expect(listshosts2.nvdecimals, isNotNull);
      expect(listshosts2.nvdoubles, isNotNull);
      expect(listshosts2.nvdurations, isNotNull);
      expect(listshosts2.nvints, isNotNull);
      expect(listshosts2.nvstrings, isNotNull);

      expect(listshosts2.nvapplianceTypes, listshost.nvapplianceTypes);
      expect(listshosts2.nvbools, listshost.nvbools);
      expect(listshosts2.nvdatetimes, listshost.nvdatetimes);
      expect(listshosts2.nvdecimals, listshost.nvdecimals);
      expect(listshosts2.nvdoubles, listshost.nvdoubles);
      expect(listshosts2.nvdurations, listshost.nvdurations);
      expect(listshosts2.nvints, listshost.nvints);
      expect(listshosts2.nvstrings, listshost.nvstrings);
    });
  });
}

ListsHost _listsHost([bool nullsWithValues = false]) => ListsHost(
      vstrings: ['a', 'b'],
      nvstrings: nullsWithValues ? ['c', 'd', 'r'] : null,
      vdurations: [Duration(hours: 2), Duration(hours: 5, minutes: 3)],
      nvdurations:
          nullsWithValues ? [Duration(hours: 7), Duration(hours: 2)] : null,
      vdatetimes: [DateTime(2020, 06, 05), DateTime(2021, 02, 5, 23, 23, 12)],
      nvdatetimes: nullsWithValues
          ? [DateTime(2020, 06, 05), DateTime(2021, 02, 5, 23, 23, 12)]
          : null,
      vdecimals: [Decimal.parse('23.22'), Decimal.fromInt(10)],
      nvdecimals: nullsWithValues
          ? [Decimal.parse('43.21'), Decimal.one, Decimal.parse('12.1')]
          : null,
      vints: [33, 112, 223],
      nvints: nullsWithValues ? [55, 2, 1, 8] : null,
      vdoubles: [12.44, 776.44],
      nvdoubles: nullsWithValues ? [6, 7.8, 3] : null,
      vapplianceTypes: [ApplianceType.Cutlery, ApplianceType.Heat],
      nvapplianceTypes: nullsWithValues ? [ApplianceType.Heat] : null,
      vbools: [true, false],
      nvbools: nullsWithValues ? [false, false, true] : null,
    );

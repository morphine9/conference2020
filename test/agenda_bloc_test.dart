import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  group('Agenda Bloc tests', () {
    AgendaBloc bloc;

    setUp(() {
      bloc = AgendaBloc();
    });

    test('Initial state is correct', () {
      expect(bloc.initialState, isA<InitialAgendaState>());
    });

    test('InitAgenda event populates the state', () {
      expectLater(
          bloc,
          emitsInOrder([
            isA<InitialAgendaState>(),
            isA<LoadingAgendaState>(),
            isA<PopulatedAgendaState>(),
          ]));

      bloc.add(InitAgenda());
    });

    test('InitAgenda event populates the state with default day 1', () {
      expectLater(
          bloc,
          emitsInOrder([
            isA<InitialAgendaState>(),
            isA<LoadingAgendaState>(),
            isA<PopulatedAgendaState>().having(
              (x) => x.selectedDay.year,
              'default selected year',
              2020,
            ),
          ]));

      bloc.add(InitAgenda());
    });

    test('SwitchDay event changes the selected day', () {
      final targetDay = DateTime(2020, 1, 23);

      expectLater(
          bloc,
          emitsInOrder([
            // isA<InitialAgendaState>(),
            isA<PopulatedAgendaState>().having(
              (x) => x.selectedDay,
              'selected day',
              targetDay,
            ),
          ]));

      bloc.add(SwitchDay(targetDay));
    });

    tearDown(() {
      bloc.close();
    });
  });
}
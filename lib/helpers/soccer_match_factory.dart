import 'package:faker/faker.dart';
import 'package:futebol/src/domain/entities/Match/match_entity.dart';

abstract class MatchFactory {
  static SoccerMatch generateMatch() {
    final Faker faker = Faker();

    return SoccerMatch(
      id: faker.randomGenerator.integer(50),
      idSelection1: faker.randomGenerator.integer(32),
      idSelection2: faker.randomGenerator.integer(32),
      local: faker.address.city(),
      date: faker.date.dateTime().toString(),
      hour: faker.date.time(),
      type: faker.randomGenerator.integer(5),
    );
  }

  static SoccerMatch generateMatchWithType(int type) {
    final Faker faker = Faker();

    return SoccerMatch(
      id: faker.randomGenerator.integer(50),
      idSelection1: faker.randomGenerator.integer(32),
      idSelection2: faker.randomGenerator.integer(32),
      local: faker.address.city(),
      date: faker.date.dateTime().toString(),
      hour: faker.date.time(),
      type: type,
    );
  }

  static SoccerMatch generateMatchWithGroup(String group) {
    final Faker faker = Faker();

    return SoccerMatch(
      id: faker.randomGenerator.integer(50),
      idSelection1: faker.randomGenerator.integer(32),
      idSelection2: faker.randomGenerator.integer(32),
      local: faker.address.city(),
      date: faker.date.dateTime().toString(),
      hour: faker.date.time(),
      type: SoccerMatchType.group,
      group: group,
    );
  }
}

import 'package:faker/faker.dart';

import 'package:futebol/src/domain/entities/Selection/selection_entity.dart';

abstract class FakeFactory {
  static Selecao generateSelecao() {
    final faker = Faker();
    return Selecao(
      id: faker.randomGenerator.integer(30),
      nome: faker.person.firstName(),
      bandeira: faker.image.image(),
      grupo: faker.randomGenerator.string(1),
      gc: faker.randomGenerator.integer(20),
      gp: faker.randomGenerator.integer(20),
      pontos: faker.randomGenerator.integer(20),
      vitorias: faker.randomGenerator.integer(20),
    );
  }

  static Selecao generateSelecaoWithGroup(String group) {
    final faker = Faker();
    return Selecao(
      id: faker.randomGenerator.integer(30),
      nome: faker.person.firstName(),
      bandeira: faker.image.image(),
      grupo: group,
      gc: faker.randomGenerator.integer(20),
      gp: faker.randomGenerator.integer(20),
      pontos: faker.randomGenerator.integer(20),
      vitorias: faker.randomGenerator.integer(20),
    );
  }
}

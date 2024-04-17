import 'dart:io';
import "habilidad.dart";
import "pokemon.dart";
import 'dart:math';

class App {
  inicializacion() async {
    var pokemon1 = pokemonrandom();
    await imprimirGenerado(pokemon1);

    String respuesta = pedirNombre();
    await imprimir(respuesta);
    elegirHabilidad();
  }

  pokemonrandom() {
    var random = Random();
    var randomNumber = random.nextInt(1302) + 1;
    return randomNumber;
  }

  imprimir(var respuesta) async {
    Pokemon pokemon = Pokemon();
    pokemon = await Pokemon().obtenerPokemon(respuesta);
    stdout.writeln("Pokemon elegido: ${pokemon.nombre}");
    stdout.writeln("Estadísticas:");
    stdout.writeln("    Vida:             ${pokemon.vida}");
    stdout.writeln("    Ataque:           ${pokemon.ataque}");
    stdout.writeln("    Defensa:          ${pokemon.defensa}");
    stdout.writeln("    Velocidad:        ${pokemon.velocidad}");
    stdout.writeln("Tipos:");
    for (var elemento in pokemon.tipos) {
      stdout.writeln("    $elemento");
    }
    stdout.writeln("Habilidades:");
    for (Habilidad elemento in pokemon.habilidades) {
      stdout.writeln("    ${elemento.nombre?.toUpperCase()}");
    }
  }

  imprimirGenerado(var respuesta) async {
    Pokemon pokemon = Pokemon();
    pokemon = await Pokemon().obtenerPokemon(respuesta);
    stdout.writeln("Ha aparecido un pokemon salvaje y es: ${pokemon.nombre}");
    stdout.writeln("Estadísticas:");
    stdout.writeln("    Vida:             ${pokemon.vida}");
    stdout.writeln("    Ataque:           ${pokemon.ataque}");
    stdout.writeln("    Defensa:          ${pokemon.defensa}");
    stdout.writeln("    Velocidad:        ${pokemon.velocidad}");
    stdout.writeln("Tipos:");
    for (var elemento in pokemon.tipos) {
      stdout.writeln("    $elemento");
    }
    stdout.writeln("Habilidades:");
    for (Habilidad elemento in pokemon.habilidades) {
      stdout.writeln("    ${elemento.nombre?.toUpperCase()}");
      var habilidad1 = stdout.writeln("    ${elemento.nombre?.toUpperCase()}");
      return habilidad1;
    }
  }

  elegirHabilidad() async {
    stdout.writeln("""Elige que habilidad usar:
    1
    2
    3""");
  }
}

String pedirNombre() {
  stdout.writeln("Escribe el nombre del pokémon con el que quieres luchar");
  return stdin.readLineSync() ?? "error";
}

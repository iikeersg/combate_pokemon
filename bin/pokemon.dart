import 'habilidad.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'dart:io';
import 'pokedex.dart';

class Pokemon {
  String? nombre;
  List<String> tipos = [];
  List<Habilidad> habilidades = [];
  int? vida;
  int? ataque;
  int? defensa;
  int? ataqueEspecial;
  int? defensaEspecial;
  int? velocidad;

  Pokemon();
  Pokemon.fromAPI(datos, listaHabilidades) {
    nombre = datos['name'];
    for (var elemento in datos['types']) {
      tipos.add(elemento['type']['name']);
    }
    for (var elemento in listaHabilidades) {
      habilidades.add(elemento);
    }
    for (var elemento in datos['stats']) {
      switch (elemento['stat']['name']) {
        case 'hp':
          vida = elemento['base_stat'];
          break;
        case 'attack':
          ataque = elemento['base_stat'];
          break;
        case 'defense':
          defensa = elemento['base_stat'];
          break;
        case 'special-attack':
          ataqueEspecial = elemento['base_stat'];
          break;
        case 'special-defense':
          defensaEspecial = elemento['base_stat'];
          break;
        case 'speed':
          velocidad = elemento['base_stat'];
          break;
      }
    }
  }

  listaDeHabilidades(datos) async {
    List<Habilidad> lista = [];
    for (var elemento in datos['abilities']) {
      lista
          .add(await Habilidad().obtenerHabilidad(elemento['ability']['name']));
    }
    return lista;
  }

  obtenerPokemon(var nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        List lista =
            await Pokemon().listaDeHabilidades(json.decode(respuesta.body));
        Pokemon pokemon = Pokemon.fromAPI(json.decode(respuesta.body), lista);
        return pokemon;
      } else if (respuesta.statusCode == 404) {
        throw ("El pokemon que buscas no existe!");
      } else
        throw ("Ha habido un error de conexión");
    } catch (e) {
      stdout.writeln(e);
      main();
    }
  }
}

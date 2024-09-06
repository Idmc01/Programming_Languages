
lista_rondas_usuarios(ListaUsuariosRondas) :-
    findall(Usuario-Rondas, rondas_usuario(Usuario, Rondas), ListaUsuariosRondas).
% Cargar el puntaje de los usuarios desde un archivo
cargar_rondas :-
    retractall(rondas_usuario(_, _)),
    exists_file('rondas_usuarios.txt'),
    consult('rondas_usuarios.txt').

% generar secuencia de 4 elementos
secuencia(N, Secuencia) :-
    length(Secuencia, N),
    maplist(random_between(1, 6), Secuencia),
    /*Mostrar la secuencia(para pruebas)*/
    writeln(Secuencia).

% evaluación de jugada
evaluarJugada(Secuencia, Jugada, CorrectosPosicion, CorrectosValor) :-
    evaluarPosicion(Secuencia, Jugada, CorrectosPosicion),
    evaluarValor(Secuencia, Jugada, CorrectosValor).

% evaluacion de jugada por posicion
evaluarPosicion([], [], 0).
evaluarPosicion([X|Secuencia], [X|Jugada], CorrectosPosicion) :-
    evaluarPosicion(Secuencia, Jugada, Restantes),
    CorrectosPosicion is Restantes + 1.
evaluarPosicion([_|Secuencia], [_|Jugada], CorrectosPosicion) :-
    evaluarPosicion(Secuencia, Jugada, CorrectosPosicion).

% evaluacion de jugada por valor
evaluarValor(Secuencia, Jugada, CorrectosValor) :-
    intersection(Secuencia, Jugada, Comunes),
    length(Comunes, ComunesLength),
    CorrectosValor is ComunesLength.

% mostrar evaluacion de jugada
evaluacion(CorrectosPosicion, CorrectosValor) :-
    format('Correctos en color y posicion: ~w~n', [CorrectosPosicion]),
    format('Correctos solo en color: ~w~n', [CorrectosValor]).
% necesario para guardar rondas en archivo
:- dynamic rondas_usuario/2.
% guardar rondas en un archivo
guardarTurno :-
    tell('rondas_usuarios.txt'),
    listing(rondas_usuario/2),
    told.
% registrar nuevo puntaje
registrarTurno(Usuario, Rondas) :-
    assertz(rondas_usuario(Usuario, Rondas)),
    guardarTurno.

% ordenar puntajes
ordenarPuntaje(UsuariosOrdenados) :-
    findall(Rondas-Usuario, rondas_usuario(Usuario, Rondas), Lista),
    keysort(Lista, ListaOrdenada),
    reverse(ListaOrdenada, UsuariosOrdenados).
% función principal
jugar(Secuencia, Rondas) :-
    repeat,
    write('Ingrese su jugada (por ejemplo: [1,2,3,4]): '),
    read(Jugada),
    evaluarJugada(Secuencia, Jugada, CorrectosPosicion, CorrectosValor),
    evaluacion(CorrectosPosicion, CorrectosValor),
    (CorrectosPosicion = 4 -> writeln('¡Felicidades! Has ganado.'),
    Contarrondas is Rondas + 1,
    registrarTurno(usuario, Contarrondas); fail).
% llamado a la función principal
iniciar :-
    writeln('¡Bienvenido a Mente Maestra!'),
    write('Por favor, ingrese su nombre: '),
    read(Nombre),
    cicloPrincipal(Nombre).

% ciclo principal del juego
cicloPrincipal(Nombre) :-
    repeat,
    menu,
    read(Opcion),
    opcion(Opcion, Nombre),
    (Opcion = 4 -> !; cicloPrincipal(Nombre)).

% menu de opciones
menu :-
    writeln('Menu:'),
    writeln('1. Jugar: la maquina escoge una configuracion aleatoria, usted adivina'),
    writeln('2. Jugar: usted escoge una configuracion aleatoria y la maquina adivina'),
    writeln('3. Ver tabla de mejores puntajes (menor cantidad de rondas para ganar)'),
    writeln('4. Salir'),
    write('Seleccione una opcion: ').

% elegir opcion
opcion(1, Nombre) :-
    secuencia(4, Secuencia),
    jugar(Secuencia, 1).
opcion(3, Nombre) :-
    lista_rondas_usuarios(ListaUsuariosRondas).

opcion(4, Nombre) :-
    writeln('¡Hasta luego, '), write(Nombre), writeln('!').

% Iniciar el juego
:- iniciar.


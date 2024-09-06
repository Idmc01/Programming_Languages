#!/bin/bash

#Ubicación cowsay
PATH=$PATH:/usr/games

mensajeSleep(){
    cowsay "🤫🧏 bye bye"
    exit 1
}

sighUp(){
    cowsay "Mondongo"
    exit 1
}

sigInt_sigTermo(){
    cowsay "
⠀⠀⠀⠀⠀⠀⢀⢄⡒⠒⡒⠀⢰⠒⣒⢶⠤⡀⠀⠀⠀
⠀⠀⠀⠀⠀⡰⡩⠂⠀⠀⠀⠀⠀⠣⡊⠙⣷⢱⠀⠀⠀
⠀⠀⠀⠀⣰⡑⣀⣂⡠⢀⠀⠀⠄⡀⡌⡃⡽⢽⡆⠀⠀
⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣶⣶⣦⡤⢄⣌⣻⣇⠀⠀
⠀⠀⠀⠀⠀⣾⣿⠟⠻⣿⡿⠛⠁⠀⢷⡄⣿⢿⢿⠀⠀
⠀⠀⠀⠀⡘⡠⢀⣠⢲⠃⢁⠀⠀⢠⠖⠛⠓⢸⣼⡄⠀
⠀⠀⠀⢰⢋⡴⢋⡏⡜⠐⠁⠈⠤⠀⠀⠀⠀⢮⣻⣧⠀
⠀⣀⠔⠕⠒⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⡀⠐⢻⡟⢹⡀
⠰⣷⣶⣤⣤⣄⣀⣀⣴⣦⡆⠀⠀⠀⡠⡂⠀⠈⢷⡴⡇
⠀⠀⣼⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⢀⠇⣴⣿⣶⣾⣿⣧
⠀⢰⣯⣭⣭⣌⣀⣀⠀⠀⠀⠀⠀⠀⠀⠋⢿⣿⣿⣿⣿
⠀⠀⣿⣿⣿⣿⣿⣿⣯⡿⠔⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿
⠀⠀⢸⣿⣿⣿⡿⠛⠀⠀⠀⠀⠀⡀⠀⠀⢐⣿⣿⣿⡇
⠀⠀⠘⣿⣿⣿⣥⣄⣰⣊⣤⣀⣤⣶⣶⣿⣿⣿⣿⣿⠇
⠀⠀⠀⠀⠉⠛⠛⠛⠛⠻⠿⠿⠿⠿⠿⠿⠿⠿⠛⠁⠀"
    exit 1
}

trap sighUp SIGHUP
trap sigInt_sigTermo SIGINT SIGTERM


cowsay "Como tan muchacho?"


sleep 10&
PIDEspera=$!
wait $PIDEspera

mensajeSleep
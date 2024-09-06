# Describa como implementó el script taunt.sh. En particular, discuta brevemente:

## ¿Cómo manejó las distintas señales?

Lo manejé con las lineas `trap sighUp SIGHUP` y `trap sigInt_sigTermo SIGINT SIGTERM`, trap es un comando que permite especificar un comando o función a ejecutar cuando se recibe una señal, en este caso al recibir alguna de las señales `SIGHUP, SIGINT, SIGTERM` se llama a la función al lado de esa señal, la cual se encarga de imprimir el mensaje de cowsay y terminar el programa.

## ¿Cómo le pasó los mensajes cowsay?

Se requiere de una segunda terminal para este proceso, mientras la terminal principal corre el script, a la segunda se le corre el comando `ps aux | grep taunt.sh`, este retorna una serie de datos, pero el segundo en apaarecer es el importante, es el número PID del script, con este número se puede ejecutar el comando `kill -SIGHUP <PID>`, se puede cambiar SIGHUP por cualquiera de los otros mensajes, y el PID iria son los símbolos <>, un ejemplo de como se vería a la hora de ejecutarlo sería `kill -SIGTERM 1234`, de esta forma se pueden enviar los mensajes para obtener los diferentes mensajes.

## ¿Cómo manejó timeout?

Se creó una función que llama a cowsay con el mensaje para finalizar, esta función se llama luego de 10 segundos de iniciado el script mediante las siguientes líneas de código:
```
sleep 10&
PIDEspera=$!
wait $PIDEspera

mensajeSleep
```

la primer línea envia el mensaje para que el programa "duerma" por 10 segundos, el símbolo "&" indica que el comando se ejecuta en segundo plano, la segunda línea guarda el PID del último proceso ejecutado, en este caso el `sleep 10&` y se guarda su valor en la variable PIDEspera, por último la tercer linea utiliza la función `wait` para espera a que termine un proceso en segundo plano y se le envia el PIDEspera para que sepa que es ese proceso por el que tiene que esperar, una vez acaba se llama a mensajeSleep, que es la función que imprime el mensaje al finalizar los 10 segundos.

# Compare el escribir shell scripts con el escribir programas en C. ¿Cuál es más facil? ¿Cuál prefiere? ¿Cuando es que usaría una en vez del otro?

Por el conocimiento y la sintaxis prefiero 'C', más porque es menos engorroso enviar los valores de los parametros o los mensajes como los que habia que enviar desde otra cnsola para este ejercicio, sin embargo, para manejar archivos y realizar acciones como las que se requerian para 'cocine.sh' si se vuelve más facil usar shell scripts, ya que con solo llamarlo se compilan los códigos y se ahorra escribir el gran comando necesario para hacerlo desde consola, depende del caso de uso si se preferiria usar uno otro.
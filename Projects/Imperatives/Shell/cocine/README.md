#  Describa como implementó el script cocine.sh script. En particular, discuta brevemente:

### ¿Cómo manejó asignar valores default a las variables?

Para asignarle valores a las variables `SUFIJOS, CC Y CFLAGS` se utilizó el siguiente código:

```
SUFIJOS=${SUFIJOS:-.c}
CC=${CC:-gcc}
CFLAGS=${CFLAGS:--std=gnu99 -Wall}
```

los cuales muestran las sintaxis para darle un valor a una variable, especificamente sería `VARIABLE=${VARIABLE:-"VALOR"}`.

###  ¿Cómo iteró por todos los archivos que hacian match con SUFIJOS?

Se utiliza un ciclo, que recorre todo el directorio en busca de archivos que compartan el SUFIJO, la sección de código que permite esto se ve de la forma:
```
for archivo in *$SUFIJOS; do
  if [ -f "$archivo" ]; then
    compilarArchivo "$archivo"
  fi
done
```
Donde si encuentra el sufijo, guarda en base_name el nombre del archivo con la línea `local base_name=$(basename "$file" "$SUFIJOS")` y se lo envía a la función compilarArchivo la cual se encarga de correr el comando de compilación.

### ¿Cómo manejó la variable VERBOSE.?

Con la siguiente línea de código:
```
[ ! -z "$VERBOSE" ] && echo $cmd
```
Al principio de la función `compilarArchivo` se define `cmd` como la combinación de las variables  `CC, CFLAGS, base_name y archivo` ordenadas para ejecutar el comando de compilación, pero con la línea mostrada anteriormente, si se define el valor de la variable `VERBOSE` se imprime en consola lo que diga `cmd`.

### ¿Cómo hizo para terminar rápido una vez que la compilación fallaba?

Con el siguiente código:

```
$cmd
  if [ $? -ne 0 ]; then
    echo "Error: La compilación falló para el archivo $archivo"
    exit 1
  fi
```
Este ejecuta el comando guardado en `cmd` y verifica el código de salida, si retorna 0 imprime el mensaje de error y termina el script.

### Compara utilizar cocine.sh con make. ¿Cuáles son las ventajas y desventajas de ambos métodos de compilación automática? ¿Qué utilizará en el futuro (cocine.sh, make, o algo distinto)?

Investigando es complejo rearmar solo lo necesario para la compilación en un .sh, dando como solución factible rearmar todo el script, en un proyecto como este, no hay problema por lo pequeño que es, pero en uno grande consumiría mucho más tiempo, al contrario de make al que si se le es posible mencionar que partes del programa dependen de que parte del script y solamente rearmar esas partes necesarias, en el futuro, dependeria de la cantidad de archivos .c que desee compilar, si fueran muchos, usaría make, si son pocos no hay problema en usar .sh.
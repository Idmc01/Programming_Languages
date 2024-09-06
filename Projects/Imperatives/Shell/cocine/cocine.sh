#!/bin/sh

# Valores por defecto
SUFIJOS=${SUFIJOS:-.c}
CC=${CC:-gcc}
CFLAGS=${CFLAGS:--std=gnu99 -Wall}

# Función para compilar un archivo fuente
compilarArchivo() {
  local archivo=$1
  local base_name=$(basename "$archivo" "$SUFIJOS")
  local cmd="$CC $CFLAGS -o $base_name $archivo"

  # Mostrar el comando si VERBOSE está definido
  [ ! -z "$VERBOSE" ] && echo $cmd

  # Ejecutar el comando de compilación
  $cmd
  if [ $? -ne 0 ]; then
    echo "Error: La compilación falló para el archivo $archivo"
    exit 1
  fi
}

# Buscar y compilar archivos que coincidan con SUFIJOS
for archivo in *$SUFIJOS; do
  if [ -f "$archivo" ]; then
    compilarArchivo "$archivo"
  fi
done

# Finalización exitosa
exit 0


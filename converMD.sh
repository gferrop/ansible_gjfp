#!/bin/bash

# Script para generar un documento Markdown (.md) a partir de un archivo YAML (.yml)
# El script pregunta al usuario qué archivo YAML procesar.

# Función para verificar si un comando está disponible
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Verificar si 'yq' está instalado
if ! command_exists yq; then
  echo "Error: 'yq' no está instalado. Por favor, instálalo para continuar."
  echo "  Puedes instalarlo con: "
  echo "    - En Debian/Ubuntu: sudo apt-get install yq"
  echo "    - En macOS (con Homebrew): brew install yq"
  echo "    - En otros sistemas, consulta la documentación de yq: https://mikefarah.gitbook.io/yq/"
  exit 1
fi

# Función para generar el Markdown a partir del YAML
generate_markdown() {
  local yaml_file="$1"
  local md_file="${yaml_file%.*}.md" # Reemplaza la extensión .yml por .md

  echo "Generando Markdown para: $yaml_file"

  # Verificar si el archivo YAML existe
  if [[ ! -f "$yaml_file" ]]; then
    echo "Error: El archivo YAML '$yaml_file' no existe."
    return 1
  fi

  # Extraer la descripción del YAML (si existe)
  description=$(yq eval '.description' "$yaml_file" 2>/dev/null)
  if [[ -z "$description" ]]; then
    description="Descripción no disponible."
  fi

  # Extraer el título del YAML (si existe)
  title=$(yq eval '.title' "$yaml_file" 2>/dev/null)
  if [[ -z "$title" ]]; then
    title=$(basename "$yaml_file" .yml)
  fi

  # Crear el contenido del archivo Markdown
  cat > "$md_file" <<EOF
# $title

$description

## Detalles

\`\`\`yaml
$(cat "$yaml_file")
\`\`\`

EOF

  echo "Archivo Markdown generado: $md_file"
  return 0
}

# Preguntar al usuario qué archivo YAML procesar
read -p "Introduce el nombre del archivo YAML (ej: mi_script.yml): " yaml_file

# Verificar si el usuario ha introducido algo
if [[ -z "$yaml_file" ]]; then
  echo "Error: Debes introducir el nombre de un archivo YAML."
  exit 1
fi

# Verificar si el archivo tiene la extensión .yml
if [[ "${yaml_file##*.}" != "yml" ]]; then
  echo "Error: El archivo debe tener la extensión .yml"
  exit 1
fi

# Generar el Markdown
generate_markdown "$yaml_file"

exit $?


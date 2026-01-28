#!/bin/bash

# Script para crear el archivo sample.war
# Práctica 2.4/2.8 - Despliegue de Tomcat con Nginx

echo "================================================"
echo "  Creando archivo sample.war"
echo "================================================"
echo ""

# Verificar que existe el directorio sample
if [ ! -d "sample" ]; then
    echo "❌ Error: No se encuentra el directorio 'sample'"
    echo "   Asegúrate de ejecutar este script desde el directorio 'recursos'"
    exit 1
fi

# Cambiar al directorio sample
cd sample

# Crear el archivo WAR usando jar o zip
echo "📦 Empaquetando aplicación..."

if command -v jar &> /dev/null; then
    echo "   Usando comando 'jar'..."
    jar -cvf ../sample.war * > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Archivo sample.war creado exitosamente con jar"
    else
        echo "❌ Error al crear el archivo WAR con jar"
        exit 1
    fi
elif command -v zip &> /dev/null; then
    echo "   Usando comando 'zip'..."
    zip -r ../sample.war * > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Archivo sample.war creado exitosamente con zip"
    else
        echo "❌ Error al crear el archivo WAR con zip"
        exit 1
    fi
else
    echo "❌ Error: No se encuentra 'jar' ni 'zip' en el sistema"
    echo "   Instala JDK o zip para continuar"
    exit 1
fi

# Volver al directorio anterior
cd ..

# Verificar que el archivo se creó correctamente
if [ -f "sample.war" ]; then
    SIZE=$(du -h sample.war | cut -f1)
    echo ""
    echo "================================================"
    echo "✅ Archivo creado exitosamente"
    echo "================================================"
    echo "📄 Archivo: sample.war"
    echo "📊 Tamaño: $SIZE"
    echo "📁 Ubicación: $(pwd)/sample.war"
    echo ""
    echo "🔍 Contenido del archivo WAR:"
    echo "------------------------------------------------"
    
    if command -v jar &> /dev/null; then
        jar -tvf sample.war
    elif command -v unzip &> /dev/null; then
        unzip -l sample.war
    fi
    
    echo ""
    echo "================================================"
    echo "🚀 Ya puedes usar sample.war en tu práctica"
    echo "================================================"
    echo ""
    echo "Pasos siguientes:"
    echo "1. Copia sample.war a tu directorio de trabajo"
    echo "2. Móntalo en el contenedor de Tomcat"
    echo "3. Accede a http://localhost/sample/"
    echo ""
else
    echo "❌ Error: El archivo sample.war no se creó"
    exit 1
fi

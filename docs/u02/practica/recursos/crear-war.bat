@echo off
REM Script para crear el archivo sample.war en Windows
REM Práctica 2.4/2.8 - Despliegue de Tomcat con Nginx

echo ================================================
echo   Creando archivo sample.war
echo ================================================
echo.

REM Verificar que existe el directorio sample
if not exist "sample" (
    echo ERROR: No se encuentra el directorio 'sample'
    echo        Asegurate de ejecutar este script desde el directorio 'recursos'
    pause
    exit /b 1
)

REM Cambiar al directorio sample
cd sample

REM Crear el archivo WAR usando jar
echo Empaquetando aplicacion...

REM Intentar con jar primero
where jar >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo    Usando comando 'jar'...
    jar -cvf ..\sample.war * >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo Archivo sample.war creado exitosamente con jar
        goto :success
    ) else (
        echo Error al crear el archivo WAR con jar
        cd ..
        pause
        exit /b 1
    )
)

REM Si no está jar, intentar con PowerShell
echo    Usando PowerShell Compress-Archive...
powershell -Command "Compress-Archive -Path * -DestinationPath ..\sample.zip -Force" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    cd ..
    if exist sample.war del sample.war
    ren sample.zip sample.war
    echo Archivo sample.war creado exitosamente con PowerShell
    goto :success
) else (
    echo Error al crear el archivo WAR
    cd ..
    pause
    exit /b 1
)

:success
cd ..

REM Verificar que el archivo se creó correctamente
if exist "sample.war" (
    echo.
    echo ================================================
    echo Archivo creado exitosamente
    echo ================================================
    echo Archivo: sample.war
    for %%A in (sample.war) do echo Tamano: %%~zA bytes
    echo Ubicacion: %CD%\sample.war
    echo.
    
    REM Mostrar contenido si jar está disponible
    where jar >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo Contenido del archivo WAR:
        echo ------------------------------------------------
        jar -tvf sample.war
    )
    
    echo.
    echo ================================================
    echo Ya puedes usar sample.war en tu practica
    echo ================================================
    echo.
    echo Pasos siguientes:
    echo 1. Copia sample.war a tu directorio de trabajo
    echo 2. Montalo en el contenedor de Tomcat
    echo 3. Accede a http://localhost/sample/
    echo.
) else (
    echo ERROR: El archivo sample.war no se creo
    pause
    exit /b 1
)

pause

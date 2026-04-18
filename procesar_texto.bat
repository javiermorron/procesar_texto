@echo off
setlocal EnableDelayedExpansion
chcp 1252 >nul
cd /d "%~dp0"
cls

echo.
echo ============================================================
echo      CONVERSOR A MAYUSCULAS + EXTRACTOR DE DATOS
echo ============================================================
echo.

set "ARCHIVO_ENTRADA="
for %%F in ("%~dp0*.txt") do (
    if "!ARCHIVO_ENTRADA!"=="" set "ARCHIVO_ENTRADA=%%F"
)

if "!ARCHIVO_ENTRADA!"=="" (
    echo No se encontro ningun .txt en esta carpeta.
    set /p "ARCHIVO_ENTRADA= Escribe la ruta completa del .txt: "
    echo.
)

if not exist "!ARCHIVO_ENTRADA!" (
    echo [ERROR] Archivo no encontrado: !ARCHIVO_ENTRADA!
    echo.
    pause
    exit /b 1
)

echo  Archivo: !ARCHIVO_ENTRADA!
echo.

for %%F in ("!ARCHIVO_ENTRADA!") do (
    set "CARPETA=%%~dpF"
    set "BASE=%%~nF"
)
set "ARCHIVO_MAYUS=!CARPETA!!BASE!_MAYUSCULAS.txt"
set "ARCHIVO_DATOS=!CARPETA!!BASE!_DATOS.txt"

echo [1/3] Convirtiendo a mayusculas...
echo NOTA: El .txt de entrada debe estar guardado en ANSI

if exist "!ARCHIVO_MAYUS!" del "!ARCHIVO_MAYUS!"

for /f "usebackq tokens=* delims=" %%L in ("!ARCHIVO_ENTRADA!") do (
    set "LIN=%%L"
    set "LIN=!LIN:a=A!"
    set "LIN=!LIN:á=Á!"
    set "LIN=!LIN:b=B!"
    set "LIN=!LIN:c=C!"
    set "LIN=!LIN:d=D!"
    set "LIN=!LIN:e=E!"
    set "LIN=!LIN:é=É!"
    set "LIN=!LIN:f=F!"
    set "LIN=!LIN:g=G!"
    set "LIN=!LIN:h=H!"
    set "LIN=!LIN:i=I!"
    set "LIN=!LIN:í=Í!"
    set "LIN=!LIN:j=J!"
    set "LIN=!LIN:k=K!"
    set "LIN=!LIN:l=L!"
    set "LIN=!LIN:m=M!"
    set "LIN=!LIN:n=N!"
    set "LIN=!LIN:ñ=Ñ!"
    set "LIN=!LIN:o=O!"
    set "LIN=!LIN:ó=Ó!"
    set "LIN=!LIN:p=P!"
    set "LIN=!LIN:q=Q!"
    set "LIN=!LIN:r=R!"
    set "LIN=!LIN:s=S!"
    set "LIN=!LIN:t=T!"
    set "LIN=!LIN:u=U!"
    set "LIN=!LIN:ú=Ú!"
    set "LIN=!LIN:v=V!"
    set "LIN=!LIN:w=W!"
    set "LIN=!LIN:x=X!"
    set "LIN=!LIN:y=Y!"
    set "LIN=!LIN:z=Z!"
    :: Letras acentuadas - ya están arriba junto a su letra base,
    :: pero las repetimos aquí por seguridad
    set "LIN=!LIN:á=Á!" 
    set "LIN=!LIN:é=É!"
    set "LIN=!LIN:í=Í!"
    set "LIN=!LIN:ó=Ó!"
    set "LIN=!LIN:ú=Ú!"
    set "LIN=!LIN:ñ=Ñ!"
    set "LIN=!LIN:ü=Ü!"
    echo !LIN!>> "!ARCHIVO_MAYUS!"
)

echo  OK ^> !ARCHIVO_MAYUS!

echo.
echo [2/3] Extrayendo datos...

set "V_NOMBRE=No encontrado"
set "V_TEL=No encontrado"
set "V_ORIGEN=No encontrado"
set "V_DESTINO=No encontrado"
set "V_REFERENCIA=No encontrado"

for /f "usebackq tokens=* delims=" %%L in ("!ARCHIVO_ENTRADA!") do (
    set "LIN=%%L"

    echo !LIN! | findstr /i "^nombre" >nul 2>&1
    if !errorlevel!==0 if "!V_NOMBRE!"=="No encontrado" (
        for /f "tokens=2 delims=:" %%V in ("!LIN!") do set "V_NOMBRE=%%V"
    )

    echo !LIN! | findstr /i "^tel ^movil ^celular ^phone" >nul 2>&1
    if !errorlevel!==0 if "!V_TEL!"=="No encontrado" (
        for /f "tokens=2 delims=:" %%V in ("!LIN!") do set "V_TEL=%%V"
    )

    echo !LIN! | findstr /i "^origen ^origin ^desde" >nul 2>&1
    if !errorlevel!==0 if "!V_ORIGEN!"=="No encontrado" (
        for /f "tokens=2 delims=:" %%V in ("!LIN!") do set "V_ORIGEN=%%V"
    )

    echo !LIN! | findstr /i "^destino ^destination ^hasta" >nul 2>&1
    if !errorlevel!==0 if "!V_DESTINO!"=="No encontrado" (
        for /f "tokens=2 delims=:" %%V in ("!LIN!") do set "V_DESTINO=%%V"
    )

    echo !LIN! | findstr /i "^referencia" >nul 2>&1
    if !errorlevel!==0 if "!V_REFERENCIA!"=="No encontrado" (
        for /f "tokens=2 delims=:" %%V in ("!LIN!") do set "V_REFERENCIA=%%V"
    )
)

echo.
echo [3/3] Guardando resumen...

(
    echo ============================================================
    echo  DATOS EXTRAIDOS
    echo  Fuente: !ARCHIVO_ENTRADA!
    echo ============================================================
    echo   Nombre     : !V_NOMBRE!
    echo   Telefono   : !V_TEL!
    echo   Origen     : !V_ORIGEN!
    echo   Destino    : !V_DESTINO!
    echo   Referencia : !V_REFERENCIA!
    echo ============================================================
) > "!ARCHIVO_DATOS!"

echo  OK ^> !ARCHIVO_DATOS!

echo.
echo ============================================================
echo  RESULTADOS
echo ============================================================
echo   Nombre     : !V_NOMBRE!
echo   Telefono   : !V_TEL!
echo   Origen     : !V_ORIGEN!
echo   Destino    : !V_DESTINO!
echo   Referencia : !V_REFERENCIA!
echo ============================================================
echo.
echo  Carpeta de salida: !CARPETA!
echo.
pause
endlocal

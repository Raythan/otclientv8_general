@echo off
REM --- CONFIGURAÇÕES ---
REM Usa %APPDATA% para ter portabilidade (resolve para C:\Users\USUARIO\AppData\Roaming)
set "ROOT_PATH=%APPDATA%\OTClientV8\Kaldrox\bot"

REM Define a subpasta e o nome do arquivo a ser deletado.
set "SUBDIR=cavebot_configs"
set "FILENAME=IusionFree20.cfg"

echo.
echo Deletando o arquivo '%FILENAME%' em todos os perfis de bot...
echo Caminho base: %ROOT_PATH%
echo.

REM Itera sobre todas as pastas de bot dentro de %ROOT_PATH%
for /d %%D in ("%ROOT_PATH%\*") do (
    
    REM Constrói o caminho completo: %%D = (C:\...\bot\Ed Addon Um)
    set "FULL_PATH_FILE=%%D\%SUBDIR%\%FILENAME%"
    
    REM Verifica se o arquivo existe e deleta (DEL /F /Q)
    if exist "%%D\%SUBDIR%\%FILENAME%" (
        echo DELETADO: %%D\%SUBDIR%\%FILENAME%
        DEL /F /Q "%%D\%SUBDIR%\%FILENAME%"
    ) else (
        REM Opcional: Mostra quais pastas nao contem o arquivo
        REM echo Nao encontrado em: %%D
    )
)

echo.
echo Delecao concluida.
pause
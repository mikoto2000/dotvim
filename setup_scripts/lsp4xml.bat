rem lsp4xml.bat
rem
rem vim-lsp に使用する lsp4xml をダウンロードして配置する
rem
rem 配置場所: ~/.vim/lsp/lsp4xml/
rem
rem 必要なコマンド(MinGW 等で導入してください):
rem     - wget
rem     - tar

set THIS_DIR=%~dp0
set SERVER_NAME=lsp4xml

set DL_BASE_PATH=https://github.com/angelozerr/lsp4xml/releases/download/0.3.0
set DL_FILE_NAME=org.eclipse.lsp4xml-0.3.0-uber.jar

cd %THIS_DIR%\..\.vim

if not exist "lsp" (
    mkdir lsp
)

if not exist "lsp\%SERVER_NAME%" (
    mkdir lsp\%SERVER_NAME%
)

cd lsp\%SERVER_NAME%

rem lsp4xml をダウンロード
if not exist "%DL_FILE_NAME%" (
    wget.exe %DL_BASE_PATH%/%DL_FILE_NAME%
)

cd %THIS_DIR%


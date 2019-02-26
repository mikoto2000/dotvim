rem lsp4xml.bat
rem
rem vim-lsp �Ɏg�p���� lsp4xml ���_�E�����[�h���Ĕz�u����
rem
rem �z�u�ꏊ: ~/.vim/lsp/lsp4xml/
rem
rem �K�v�ȃR�}���h(MinGW ���œ������Ă�������):
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

rem lsp4xml ���_�E�����[�h
if not exist "%DL_FILE_NAME%" (
    wget.exe %DL_BASE_PATH%/%DL_FILE_NAME%
)

cd %THIS_DIR%


rem eclipse.jdt.ls.bat
rem
rem vim-lsp に使用する eclipse.jdt.ls をダウンロードして配置する
rem
rem 配置場所: ~/.vim/lsp/eclipse.jdt.ls/
rem
rem 必要なコマンド(MinGW 等で導入してください):
rem     - wget
rem     - tar

set THIS_DIR=%~dp0

cd %THIS_DIR%\..\.vim

if not exist "lsp" (
    mkdir lsp
)

if not exist "lsp\eclipse.jdt.ls" (
    mkdir lsp\eclipse.jdt.ls
)

cd lsp\eclipse.jdt.ls
rem eclipse.jdt.ls をダウンロード
set JDT_LS_BASE_PATH=http://download.eclipse.org/jdtls/snapshots
set JDT_LS_TAR_GZ=jdt-language-server-0.37.0-201904162228.tar.gz
if not exist "%JDT_LS_TAR_GZ%" (
    wget.exe %JDT_LS_BASE_PATH%/%JDT_LS_TAR_GZ%
)

rem eclipse.jdt.ls を展開(plugin フォルダの有無で展開の要否判定)
if not exist "plugins\" (
    tar.exe xf %JDT_LS_TAR_GZ%
)

cd %THIS_DIR%


@echo off

if not exist %USERPROFILE%\.vim (
    mklink /D %USERPROFILE%\.vim %USERPROFILE%\project\dotvim\.vim
)

if not exist %USERPROFILE%\.vimrc (
    mklink %USERPROFILE%\.vimrc %USERPROFILE%\project\dotvim\.vimrc
)

if not exist %USERPROFILE%\.gvimrc (
    mklink %USERPROFILE%\.gvimrc %USERPROFILE%\project\dotvim\.gvimrc
)


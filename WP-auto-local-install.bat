::::::: WP-auto-local-install.bat by Arwin | see bottom for notes ::::::: 

@echo off
cls
:_START

::: TODO variables :::
set DB_HOST=localhost
set DB_USER=root
set DB_PASS=
set PATH_HTDOCS=D:\myserver\htdocs

set MISC_WP="wordpress-3.6.1.zip"
set MISC_7Z="C:\Program Files\7-Zip\7z.exe"
set MISC_SED="D:\myserver\cmd\GnuWin32\bin\sed.exe"
set MISC_BROWSER="C:\Program Files\Google\Chrome\Application\chrome.exe"

::: tasks :::
:_TASK1
echo.
set /p PATH_DIR_NAME=Enter directory name: 
IF "%PATH_DIR_NAME%"=="" (goto _ASK1) ELSE (goto _TASK2)

:_ASK1
set /p ASK1=Do you want to continue? (yes or no): 
IF "%ASK1%"=="yes" (goto _TASK1) ELSE (goto _END)

:_TASK2
echo.
set /p DB_NAME=Enter database name: 
IF "%DB_NAME%"=="" (goto _ASK2) ELSE (goto _TASK3)

:_ASK2
set /p ASK2=Do you want to continue? (yes or no): 
IF "%ASK2%"=="yes" (goto _TASK2) ELSE (goto _END)

:_TASK3
set MISC_WEB=http://localhost/%PATH_DIR_NAME%

::::::: process :::::::
%MISC_7Z% x "%~dp0%MISC_WP%" -o"%PATH_HTDOCS%\%PATH_DIR_NAME%"
robocopy "%PATH_HTDOCS%\%PATH_DIR_NAME%\wordpress" "%PATH_HTDOCS%\%PATH_DIR_NAME%" *.* /S /MOVE
ren "%PATH_HTDOCS%\%PATH_DIR_NAME%\wp-config-sample.php" "wp-config.php"

%MISC_SED% -i s/"database_name_here"/"%DB_NAME%"/g "%PATH_HTDOCS%\%PATH_DIR_NAME%\wp-config.php"
%MISC_SED% -i s/"username_here"/"%DB_USER%"/g "%PATH_HTDOCS%\%PATH_DIR_NAME%\wp-config.php"
%MISC_SED% -i s/"password_here"/"%DB_PASS%"/g "%PATH_HTDOCS%\%PATH_DIR_NAME%\wp-config.php"
%MISC_SED% -i s/"put your unique phrase here"/"put your unique phrase here %DB_NAME%"/g "%PATH_HTDOCS%\%PATH_DIR_NAME%\wp-config.php"

mysql -u%DB_USER% --password=%DB_PASS% -e "DROP DATABASE IF EXISTS %DB_NAME%"
mysql -u%DB_USER% --password=%DB_PASS% -e "CREATE DATABASE %DB_NAME%"

explorer "%PATH_HTDOCS%\%PATH_DIR_NAME%
%MISC_BROWSER% %MISC_WEB%

:_END
exit



--------------------------------------------------------------------------------
INTRO
--------------------------------------------------------------------------------

This windows batch script will automatically install Wordpress in the htdocs 
directory. You can configure what name of the directory and database to use. 
It is best that the directory and database is not existing because this batch 
script will create that for you.

When this batch script process ends, a windows explorer will open containing 
the WP directory and a browser will open containing the WP Install page. 

On WP Install page, just set the: Site Title, Username, Password, Your E-mail 
then Click the Install Wordpress. Done :)

--------------------------------------------------------------------------------
REQUIREMENTS
--------------------------------------------------------------------------------

Windows 7+ (because robocopy is built-in on this OS)
php/mysql server
wordpress-3.6.1.zip (http://wordpress.org/latest.zip)
chrome or any browser, just update the path: MISC_BROWSER
7z (http://www.7-zip.org)
sed.exe (http://gnuwin32.sourceforge.net/downlinks/sed.php

--------------------------------------------------------------------------------
NOTES
--------------------------------------------------------------------------------

- please configure the 'TODO variables' above
- wordpress-3.6.1.zip and this batch script must be in the same directory 
- If you're using Windows XP, download robocopy and update this 
  batch script to add the robocopy path. 
 
--------------------------------------------------------------------------------
END
--------------------------------------------------------------------------------
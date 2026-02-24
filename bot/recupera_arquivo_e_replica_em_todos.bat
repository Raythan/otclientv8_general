@echo off
REM set "source=C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\MSNoob\vBot\smart_utura.lua"

REM for /d %%D in ("C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\*") do (
    REM if exist "%%D\vBot\" (
        REM xcopy "%source%" "%%D\vBot\" /Y
    REM )
REM )

set "source=C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\MSNoob\_Loader.lua"

for /d %%D in ("C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\*") do (
    if exist "%%D\" (
        xcopy "%source%" "%%D\" /Y
    )
)

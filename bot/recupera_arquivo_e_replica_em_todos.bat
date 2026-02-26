@echo off
set "source=C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\Ishikawa Ms Um\vBot\exeta.lua"

for /d %%D in ("C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\*") do (
    if exist "%%D\vBot\" (
        xcopy "%source%" "%%D\vBot\" /Y
    )
)

set "source=C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\Ishikawa Ms Um\_Loader.lua"

for /d %%D in ("C:\Users\rayth\AppData\Roaming\OTClientV8\otclientv8\bot\*") do (
    if exist "%%D\" (
        xcopy "%source%" "%%D\" /Y
    )
)

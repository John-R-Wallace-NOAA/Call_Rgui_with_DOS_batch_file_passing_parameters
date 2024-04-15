
       @echo off 
     
       echo library(stats); library(graphics); library(grDevices); library(utils); library(datasets) > .Rprofile
       echo simplePlot = function(minX, maxX, col) { plot(minX:maxX, col = col) } >> .Rprofile
       echo cat("\n\nCreating a plot from", %1, "to", %2, "with", %3, "colored points\n\n") >> .Rprofile
       echo simplePlot(%1, %2, col = %3) >> .Rprofile
       echo print(%1:%2) >> .Rprofile
       echo Sys.sleep(7) >> .Rprofile
       echo quit('no',,FALSE) >> .Rprofile
       
       echo C:\\R\\R\\bin\\x64\\Rgui.exe --no-save --no-restore --no-site-file --no-environ > run.bat
       echo exit >> run.bat
       start /wait run.bat
       del run.bat

       
     

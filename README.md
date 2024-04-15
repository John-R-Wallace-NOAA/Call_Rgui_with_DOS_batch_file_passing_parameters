### Call Rgui with a DOS batch file, for batch R graphic capabilities, and optionally pass parameters

     
Create a DOS batch file called, 'Rgui_Call.bat', with the following contents, changing the Rgui path as needed, (Rgui_Call.bat is also in this repo folder):


      @echo off 
     
       echo library(stats); library(graphics); library(grDevices); library(utils); library(datasets) > .Rprofile
       echo simplePlot = function(minX, maxX, col) { plot(minX:maxX, col = col) } >> .Rprofile
       echo cat("\n\nCreating a plot from", %1, "to", %2, "with", %3, "colored points\n\n")
       echo simplePlot(%1, %2, col = %3) >> .Rprofile
       echo print(%1:%2)
       echo Sys.sleep(7) >> .Rprofile
       echo quit('no',,FALSE) >> .Rprofile
       
       echo C:\\R\\R\\bin\\x64\\Rgui.exe --no-save --no-restore --no-site-file --no-environ > run.bat
       echo exit >> run.bat
       start /wait run.bat
       del run.bat

       
     
     
Now in a command window under the same working directory as the batch file (or with a full path on the batch file) run: 
  
      Rgui_call 1 10 'green'
      
and:
      
      Rgui_call 5 20 'dodgerblue'
      
      
Here is the same batch file contents with some remarks:

       @echo off 
       
       rem First note that the '>' operator in the Windows command shell, or Unix-a-likes shells, creates a file with the echo(ed),
       rem    line and '>>' appends what is echo(ed) to the next line.
       
       rem -- Create the local initial file '.Rprofile' which Rgui.exe will run when started --
       rem The listed packages below do not immediately load, but are standard in a normal Rgui startup.
       rem   They are loaded by the time a prompt is given, but that hasn't happen here, so these packages are loaded explictly.
       echo library(stats); library(graphics); library(grDevices); library(utils); library(datasets) > .Rprofile
       rem The classic R assignment operator "<-" does not work on the echo line.
       echo simplePlot = function(minX, maxX, col) { plot(minX:maxX, col = col) } >> .Rprofile
       echo cat("\n\nCreating a plot from", %1, "to", %2, "with", %3, "colored points\n\n") >> .Rprofile
       echo Sys.sleep(7) >> .Rprofile
       echo quit('no',,FALSE) >> .Rprofile
     
     
       rem -- Create run.bat and start it with the 'wait' argument. --
       rem        Remove the 'wait' argument (and comment out or remove the < shell("del run.bat") > line) for parallel processing.
       rem Using the change directory line below allows running the next 4 lines of R code from any working directory,
       rem    but the .Rprofile would already need to be setup in the destination directory. 
       rem    If the change directory line is used, the Rgui line would then need a ">>", not the ">".
       rem shell("echo cd C:\\A_folder_where_a_.Rprofile_is_already_setup > run.bat") 
       echo C:\\R\\R\\bin\\x64\\Rgui.exe --no-save --no-restore --no-site-file --no-environ > run.bat
       echo exit >> run.bat
       start /wait run.bat
       rem 'rem'ark out the last line for debugging
       del run.bat      

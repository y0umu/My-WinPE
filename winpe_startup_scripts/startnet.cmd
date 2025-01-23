@REM Wpeinit.exe installs Plug and Play devices, processes Unattend.xml settings, and loads network resources.
@REM see https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/wpeinit-and-startnetcmd-using-winpe-startup-scripts?view=windows-11
wpeinit

@REM Make some file associations work
@REM images
assoc .bmp=bitmapfile
assoc .gif=giffile
assoc .jpe=jpegfile
assoc .jpeg=jpegfile
assoc .jpg=jpegfile
assoc .png=pngfile
assoc .tif=TIFImage.Document
assoc .tiff=TIFImage.Document
assoc .webp=webpfile
assoc .pdf=pdffile

ftype bitmapfile="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype giffile="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype jpegfile="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype pngfile="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype TIFImage.Document="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype webpfile="X:\apps\JPEGView\JPEGView.exe" "%%1"
ftype pdffile="X:\apps\SumatraPDF\SumatraPDF-3.5.2-64.exe" "%%1"

@REM text files
assoc .js=JSFile
assoc .json=jsonfile
assoc .ini=inifile
assoc .log=logfile
assoc .md=markdownfile
assoc .txt=textfile
assoc .xml=xmlfile

ftype JSFile="X:\apps\geany\bin\geany.exe" "%%1"
ftype jsonfile="X:\apps\geany\bin\geany.exe" "%%1"
ftype inifile="X:\apps\geany\bin\geany.exe" "%%1"
ftype logfile="X:\apps\geany\bin\geany.exe" "%%1"
ftype markdownfile="X:\apps\geany\bin\geany.exe" "%%1"
ftype textfile="X:\apps\geany\bin\geany.exe" "%%1"
ftype xmlfile="X:\apps\geany\bin\geany.exe" "%%1"

@REM web pages
assoc .htm=htmlfile
assoc .html=htmlfile


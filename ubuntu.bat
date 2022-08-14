@echo off

rem "Launch the 'std' image with interactive mode."
rem "It also mounts the current directory."
docker run --rm -it -v "%cd%":/mnt/work/ -w /mnt/work/ std:latest

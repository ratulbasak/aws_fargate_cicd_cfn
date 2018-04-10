#!/bin/bash

########################################################################
################ This script runs via Dockerfile #######################
########################################################################
service nginx start
dotnet /app/WebApplication1/bin/Release/netcoreapp2.0/WebApplication1.dll

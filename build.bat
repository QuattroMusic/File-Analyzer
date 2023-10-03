@echo off

if exist analyzer.exe del analyzer.exe

jai main.jai -exe analyzer

if exist analyzer.pdb del analyzer.pdb
if exist analyzer.exe analyzer

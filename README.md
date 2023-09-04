# File-Analyzer
A fast and light file analyzer tool designed for programmers

## Features

- Fast
    Made in pure C, with some C++ helpers, to analyze the files in the most efficient possible way
- No gui
    You can analyze your files without showing the gui, but printing the data in the terminal.
    To do so, just call `FileAnalyzer.exe nogui "path/to/your/folder/or/file" "even/multiple/files!" "so/wow!"`
    You could even do `FileAnalyzer.exe "an/awesome/file" nogui`
- Drag and drop
    You can drag and drop your files to the window to begin the data parsing
- Total
    See the total of everything, how many files, how many audios, how many rows of code, etc.
- Specific languages
    We've introduced some specific data from various languages, like the symbols in brainfuck, etc.

### Supported files
- Programming language
    - [ ] C / C++
    - [ ] C#
    - [ ] Java
    - [ ] Python
    - [ ] Rust
    - [ ] Cobol
    - [ ] Fortran
    - [ ] Go
    - [ ] Ruby
    - [ ] Kotlin
    - [ ] Lua
    - [ ] V
    - [ ] Odin
    - [ ] R
    - [ ] Matlab
    - [ ] Dart
    - [ ] Brainfuck
    - [ ] Mathematica
    - [ ] Erlang
    - [ ] Elixir
    - [ ] Vim
    - [ ] Beef
    - [ ] JAML
    - [ ] Javascript
    - [ ] Typescript
    - [ ] HTML
    - [ ] CSS
    - [ ] PHP
    - [ ] Bash
    - [ ] Batch
    - [ ] Assembly x86
    - [ ] Assembly Arm
    - [ ] Powershell
    - [ ] Scala
    - [ ] Swift
    - [ ] SQL
    - [ ] Julia
    - [ ] Perl
- Image
    - [ ] jpg / jpeg
    - [ ] png
- Video
    - [ ] mp4
- Audio
    - [ ] mp3
    - [ ] wav
    - [ ] flac
    - [ ] ogg

### Obtained info

- General:
    - file amount
    - min file size
    - max file size
    - average file size
    - total file size
- Programming language:
    - rows
    - empty and non-empty rows
    - rows containing comments
    - rows containing imports
    - characters
    - digits and numbers
    - symbols
    - white spaces
    - total size
- Image:
    - min resolution
    - max resolution
- Audio:
    - min length
    - max length
    - total length
- Video:
    - min length
    - max length
    - total frames
    - min resolution
    - max resolution

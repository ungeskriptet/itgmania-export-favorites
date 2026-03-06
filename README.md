# itgmania-export-favorites
Small script to export ITGmania favorites into a separate folder

Run itgmania-export-favorites:
```
nix run https://codeberg.org/ungeskriptet/itgmania-export-favorites/archive/master.tar.gz
```

If you don't have nix, download the script and run it manually:
```
./itgmania-export-favorites.sh
```

Options:
```
-f | --favorites <path to favorites.txt> (Default: ~/.itgmania/Save/LocalProfiles/00000000/favorites.txt)
-s | --songs <path to song folder> (Default: ~/.itgmania/Songs)
-o | --out <path to output folder> (Default: itgmania-export)
-v | --verbose  Show copy progress
-h | --help     Show help and exit
```

{ writeShellScriptBin }:
writeShellScriptBin "ckcolor" ''
  #!/usr/bin/env sh
  # https://unix.stackexchange.com/a/801620
  
  TXT="This will be a smooth gradient if truecolor is supported."
  COLUMNS="''${COLUMNS:-$(tput cols || 120)}"
  FILL_L="$(printf '%*s' "$(((COLUMNS - ''${#TXT}) / 2))")"
  FILL_R="$(printf '%*s' "$(((COLUMNS - ''${#TXT}) / 2))")"
  [[ $((''${#TXT}%2)) -eq 1 ]] && FILL_R="$(printf '%*s' "$((((COLUMNS - ''${#TXT}) / 2) +1 ))")"
  FG=$(printf '%s' "$FILL_L"; printf '%s' "$TXT"; printf '%s' "$FILL_R")
  for ((COLUMN=0; COLUMN<COLUMNS; COLUMN++)); do
    # Iterate RGB values                  ; Ensure int stays within range 0..255
    ((R=255-(COLUMN*255/COLUMNS))); ((R<0))&&((R=255-(R+255))); ((R>255))&&((R=R-(R-255)))
    ((G=COLUMN*510/COLUMNS))      ; ((G<0))&&((G=255-(G+255))); ((G>255))&&((G=G-(G-255)))
    ((B=COLUMN*255/COLUMNS))      ; ((B<0))&&((B=255-(B+255))); ((B>255))&&((B=B-(B-255)))
    printf "\e[48;2;%d;%d;%dm" $R $G $B  # BG
    printf "\e[38;2;%d;%d;%d;1m" $R 0 $B # FG Color
    printf "%s\e[0m" "''${FG:''${COLUMN}:1}" # FG Content
  done
''

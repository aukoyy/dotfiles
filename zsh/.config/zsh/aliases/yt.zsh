# ----- yt-dlp -----
_yt_dlp_dl() {
  local quality="best" transcribe=false url=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -4k) quality="4k"; shift ;;
      -720) quality="720"; shift ;;
      -480) quality="480"; shift ;;
      -a) quality="audio"; shift ;;
      -t) transcribe=true; shift ;;
      -*) echo "yt: unknown option $1"; return 1 ;;
      *) url="$1"; shift ;;
    esac
  done

  if [[ -z "$url" ]]; then
    echo "Usage: yt [-4k|-720|-480|-a] [-t] <url>"
    return 1
  fi

  local dir="$HOME/youtube"
  mkdir -p "$dir"
  local out="$dir/%(uploader)s - %(title).200s.%(ext)s"

  local printfile
  local -a extra_args=()
  if [[ "$transcribe" == true ]]; then
    printfile=$(mktemp)
    extra_args=(--print-to-file "after_move:%(filepath)s" "$printfile")
  fi

  case "$quality" in
    audio)
      caffeinate -i yt-dlp -f bestaudio --extract-audio --audio-format mp3 \
        --cookies-from-browser chrome "${extra_args[@]}" -o "$out" "$url"
      ;;
    480)
      caffeinate -i yt-dlp -f "bestvideo[height<=480]+bestaudio/best[height<=480]/best" \
        --merge-output-format mp4 --embed-chapters \
        --cookies-from-browser chrome "${extra_args[@]}" -o "$out" "$url"
      ;;
    720)
      caffeinate -i yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]/best" \
        --merge-output-format mp4 --embed-chapters \
        --cookies-from-browser chrome "${extra_args[@]}" -o "$out" "$url"
      ;;
    4k)
      caffeinate -i yt-dlp -f "bestvideo[height<=2160]+bestaudio/best[height<=2160]/best" \
        --merge-output-format mp4 --embed-chapters \
        --cookies-from-browser chrome "${extra_args[@]}" -o "$out" "$url"
      ;;
    best)
      caffeinate -i yt-dlp -f bestvideo+bestaudio \
        --merge-output-format mp4 --embed-chapters \
        --cookies-from-browser chrome "${extra_args[@]}" -o "$out" "$url"
      ;;
  esac

  if [[ "$transcribe" == true ]]; then
    local dest="$HOME/youtube/transcribe"
    mkdir -p "$dest"
    if [[ -s "$printfile" ]]; then
      while IFS= read -r f; do
        [[ -f "$f" ]] && mv "$f" "$dest/"
      done < "$printfile"
    fi
    rm -f "$printfile"
  fi
}
alias yt='noglob _yt_dlp_dl'

#!/bin/bash
# Batch face swap: SOURCE_DIR and TARGET_DIR images paired by index, output to OUTPUT_DIR
# Default: source=/workspace/data/preproc_source, target=/workspace/data/FFHQ/ffhq_safe_real, out=/workspace/e4s/results

REPO=/workspace/e4s
SOURCE_DIR="${SOURCE_DIR:-/workspace/data/source}"
TARGET_DIR="${TARGET_DIR:-/workspace/data/FFHQ/ffhq_safe_real}"
OUTPUT_DIR="${OUTPUT_DIR:-/workspace/e4s/results}"

cd "$REPO"
mkdir -p "$OUTPUT_DIR"

get_imgs() {
  find "$1" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) 2>/dev/null | sort
}

sources=()
while IFS= read -r line; do sources+=("$line"); done < <(get_imgs "$SOURCE_DIR")
targets=()
while IFS= read -r line; do targets+=("$line"); done < <(get_imgs "$TARGET_DIR")

[ ${#sources[@]} -eq 0 ] && echo "No source images in $SOURCE_DIR" && exit 1
[ ${#targets[@]} -eq 0 ] && echo "No target images in $TARGET_DIR" && exit 1

n=$(( ${#sources[@]} < ${#targets[@]} ? ${#sources[@]} : ${#targets[@]} ))
echo "Processing $n pairs. Output: $OUTPUT_DIR"
for ((i=0;i<n;i++)); do
  s="${sources[$i]}"
  t="${targets[$i]}"
  echo "[$((i+1))/$n] $(basename "$s") -> $(basename "$t")"
  python scripts/face_swap.py --source "$s" --target "$t" --output_dir "$OUTPUT_DIR" || true
done
echo "Done. Results in $OUTPUT_DIR"

#!/usr/bin/bash

f=$1;
preview_time=10;
f_path=`dirname "$f"`;
f_base=`basename "$f"`;
f_no_ext="${f_base%.*}";
f_ext="${f_base##*.}";

echo "Dirname:"; 
echo "$f_path";
echo "Filename without extension:"
echo "$f_no_ext";
echo "Extension: $f_ext";

f_hms=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f" -sexagesimal`;
f_dur=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f"`;
l_dur_int=${f_dur%.*};
echo "Video duration: $f_hms";

echo "Parts preview time: $preview_time seconds"

p=0;
p_start_pos=0;
echo Partioning:

while [[ $l_dur_int -gt 0 ]]
do
p=$((p+1));

echo "Part $p:";
echo "$f_no_ext".p"$p"."$f_ext";
echo "Start position: $p_start_pos, video seconds left: $l_dur_int";

ffmpeg -hide_banner -loglevel error -ss "$p_start_pos" -y -i "$f" -fs 4200000000 -vcodec copy -acodec copy "$f_path"/"$f_no_ext".p"$p"."$f_ext";
part_hms=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f_path"/"$f_no_ext".p"$p"."$f_ext" -sexagesimal`;
part_dur=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f_path"/"$f_no_ext".p"$p"."$f_ext"`;
part_dur_int=${part_dur%.*};
echo "Duration: $part_hms = $part_dur_int seconds";


echo
# Calculation next part start position
p_start_pos=$((p_start_pos+part_dur_int-preview_time));

# Calculation seconds left:
l_dur_int=$((l_dur_int-part_dur_int));

done


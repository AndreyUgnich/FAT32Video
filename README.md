# FAT32Video

The FAT32 file system is still widely used, although it is limited by a maximum file size of (almost) 4 GiB, which is especially noticeable when it comes to video playback.

The goal of the FAT32Video algorithm is to create smaller parts from a large source video file without loss of quality, so that the size of each part is as close as possible to the file size limit of FAT32 equal to 4 GiB minus 1 byte (2³²-1 = 4 294 967 295 bytes), but did not exceed this limit.

For example, from an original video file of 10 GiB in size, you can get 3 files with approximate sizes of 3.9 + 3.9 + 2.2 GiB.

To analyze video files and split them into parts, the ffprobe and ffmpeg utilities are used.

sourceImageDirectory="/home/pi/Documents/sciaProject/sourceImages"
destinationImageDirectory="/home/pi/Documents/sciaProject/checkedImages"

If[DirectoryQ[sourceImageDirectory],NULL, Exit[]]
Print[DirectoryQ[sourceImageDirectory]]

SetDirectory[sourceImageDirectory]

files=FileNames[]
Print[files]
nextImage=Part[files,1]

Print[nextImage]

SetDirectory["/home/pi/Documents/sciaProject"]

If[DirectoryQ[destinationImageDirectory],NULL, CreateDirectory["checkedImages"]]
SetDirectory[destinationImageDirectory]
files=FileNames[nextImage]

If[FileExistsQ[nextImage] ,SetDirectory[sourceImageDirectory];DeleteFile[nextImage];Exit[]]

Print["This image doesnt already exists!"]

Import[StringJoin[sourceImageDirectory,"/",nextImage]]

sourceImageDirectory = "/home/pi/SCIAproject/sourceImages"
destinationImageDirectory = \
"/home/pi/SCIAproject/checkedImages"

If[DirectoryQ[sourceImageDirectory], NULL, Exit[]]
Print[DirectoryQ[sourceImageDirectory]]

SetDirectory[sourceImageDirectory]

files = FileNames[]
Print[files]
nextImage = Part[files, 1]

Print[nextImage]

SetDirectory["/home/pi/SCIAproject"]

If[DirectoryQ[destinationImageDirectory], NULL, 
 CreateDirectory["checkedImages"]]
SetDirectory[destinationImageDirectory]
files = FileNames[nextImage]

If[FileExistsQ[nextImage], SetDirectory[sourceImageDirectory]; 
 DeleteFile[nextImage]; Exit[]]

Print["This image doesnt already exists!"]

birds = Import[StringJoin[sourceImageDirectory, "/", nextImage]]

b = FillingTransform[ColorNegate[Binarize[birds]]];
distT = DistanceTransform[b, Padding -> 0];
marker = MaxDetect[ImageAdjust[distT], 0.0];
w = WatershedComponents[GradientFilter[b, 3], marker, 
   Method -> "Rainfall"];
bcount = SelectComponents[w, "Count", 300 < # < 3000 &];
measures = 
  ComponentMeasurements[
   bcount, {"Centroid", "EquivalentDiskRadius", "LabelCount"}];
finalImage = 
 Image[Show[birds, 
   Graphics[{Yellow, Circle @@ # & /@ (measures[[All, 2, 1 ;; 2]]), 
     MapThread[
      Text, {measures[[All, 2, 3]], measures[[All, 2, 1]]}]}]]]

Export[nextImage, finalImage]

SetDirectory[sourceImageDirectory]
DeleteFile[nextImage];

Print[measures // Length]
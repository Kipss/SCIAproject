sourceImageDirectory = "/home/pi/Documents/SCIAproject/sourceImages"
destinationImageDirectory = \
"/home/pi/Documents/SCIAproject/checkedImages"

If[DirectoryQ[sourceImageDirectory], NULL, Exit[]]
Print[DirectoryQ[sourceImageDirectory]]

SetDirectory[sourceImageDirectory]

files = FileNames[]
Print[files]
nextImage = Part[files, 1]

Print[nextImage]

SetDirectory["/home/pi/Documents/SCIAproject"]

If[DirectoryQ[destinationImageDirectory], NULL, 
 CreateDirectory["checkedImages"]]
SetDirectory[destinationImageDirectory]
files = FileNames[nextImage]

If[FileExistsQ[nextImage], SetDirectory[sourceImageDirectory]; 
 DeleteFile[nextImage]; Exit[]]

Print["This image doesnt already exists!"]

testImage = Import[StringJoin[sourceImageDirectory, "/", nextImage]]
(* Image[DeleteSmallComponents[RemoveBackground[testImage, \
{"Background",{"Uniform",0.08}}],2]] *)
Image[
 RemoveBackground[testImage, {"Background", LightBlue}]]
Image[RemoveBackground[testImage, {"Foreground", "Uniform"}]]
binTestImage = FillingTransform[ColorNegate[Binarize[testImage]]]

Image[MorphologicalComponents[testImage, .50]]
Erosion[%, 5]
MorphologicalPerimeter[%, .5]



Image[ImageData[%] /. {1 -> {0., 0., 1., .5}, 0 -> {1., 1., 1., 0.}}, 
 ColorSpace -> "RGB"]

ImageCompose[testImage, %]n

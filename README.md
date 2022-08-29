# error
this app is built for actually hiding files

onPressedAddButton() function is fired when user selected the file
and this will encrypt the file and will hide that file with randomly generated name

onPressedRestoreButton() function is fired when user selected the file for
restoring. This function will decrypt the file and move that file with its original name
in its original file location

# the actual bug
when user selects the file from DCIM the file is actually encrypted and all the process are
done. but an empty placeholder pointing is shown in the gallery

await ogFile.rename("$mainDirectory/.hmf/$tempName.hmf");
by this  line I actually moving the file from its original place to place where hidden files are
stored

I also tried that I make the copy of ogFile (original file) and place it in hidden files location
and deleted the original file. The same error occurred

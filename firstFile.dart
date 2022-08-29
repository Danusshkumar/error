  static Future<int> onPressedAddButton({context,fileType}) async {

    selectedFilesPathList = await Navigator.push(context,MaterialPageRoute(builder: (context) => MyFilePicker(fileType:fileType)));
    
    if(selectedFilesPathList.isNotEmpty) {
      for(int i = 0;i<selectedFilesPathList.length;i++){
        ogFile = File(selectedFilesPathList[i]);
        String fileSize = FilePageSupport.computeSize(ogFile);
        var tempName = randomNameGenerator();
        await MyEncryption.jsonStore({"name":path.basenameWithoutExtension(ogFile.path),"extension":path.extension(ogFile.path).split(".").last.toUpperCase(),"path":ogFile.path,"size":fileSize,"tempName":tempName});
        await ogFile.rename("$mainDirectory/.hmf/$tempName.hmf");
        var encryptedFile = await MyEncryption.encryptFunc(File("$mainDirectory/.hmf/$tempName.hmf"));
      }
    }
    return 0;
  }
  
  
  
    static onPressedRestoreButton({selectedFilesList}) async {
    for(var i = 0;i < selectedFilesList.length;i++){
      var jsonList = jsonDecode(File("$mainDirectory/.hmf/!important folder/fileInfo.json").readAsStringSync());
      var hdFileName = "";
      for(int j = 0;j<jsonList.length;j++){
        if(jsonList[j]["path"]==selectedFilesList[i]){
          hdFileName = jsonList[j]["tempName"];
        }
      }
      var decryptedFile = await MyEncryption.decryptFunc(File("$mainDirectory/.hmf/$hdFileName.hmf"));
      var extensionChangedDecryptedFile = await decryptedFile.copy("$mainDirectory/.hmf/${path.basename(decryptedFile.path)}");
      await MyEncryption.jsonRemove(path.basenameWithoutExtension(selectedFilesList[i]));
      await decryptedFile.copy(selectedFilesList[i]);//selectedFilesList contains original file's path
      await decryptedFile.delete();
    }
    selectedFilesList = [];
  }

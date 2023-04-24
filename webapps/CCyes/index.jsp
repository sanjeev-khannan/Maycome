<html>
    <head>
    <link rel="icon" href="images/MainLogo.png" type="image/gif" sizes="16x16">
    <title>MayCome</title>
        <script  src="lib/jquery-3.5.1.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="mobile-web-app-capable" content="yes">
        <style>
            @font-face {
               font-family: menuFont;
               src: url(fonts/BalsamiqSans-Regular.ttf);
            }
            .custom-file-upload {
            		    border: 1px solid #ccc;
            		    border-radius:10px;
            		    display: inline-block;
            		    padding: 5px 10px;
            		    cursor: pointer;
            		    background-color: #005194;
            		    color:white;
            		    width:auto;
            		}

            #dirArea::after{
                flex: auto;
                content:"";

            }
            .center {
              display: block;
              margin-left: auto;
              margin-right: auto;
            }
            .filFolders{
                width:99%;
                height:40%;
                padding:1px;
                color:black;
                font-size:11px;
                text-align: center;
                overflow-y:scroll;
                word-wrap:break-word;
                overflow:none;
                font-family: Verdana;
            }

            .fileContainer{
                width:80px;
                height:100px;
                display:inline-block;
                margin:1px;
                padding:2px;
            }
            .filFolders::-webkit-scrollbar {
                         display: none;
                     }
            #addressbar::-webkit-scrollbar {
               display: none;
           }
           img{
            max-width:80%;
            max-height:80%;
           }
        </style>

    </head>
    <body style="margin:0px">

    <img id="loadingGif" src="images/LOADING.gif"  style="width:200px;display: none;top:-12;left:0;right:0;margin-right:auto;margin-left: auto;position:absolute;margin-right: auto;z-index:1">
    <div id="newFolder"style="display:none;width:80%;height:11%;border:1px solid white;border-top-right-radius:20px;border-bottom-left-radius:20px;background-color:#005194;left:0;right:0;top:0;bottom:0;margin: auto;position:absolute;margin-right: auto;z-index:1;padding:15px">
        <input id="newFname" type="text" style="width:100%;height:30px;border-radius:20px;border:1px solid #005194;padding:5px">
        <button onclick="closeNewF()" class="custom-file-upload" style="left:0;right:0;margin-left:auto;margin-right:auto;font-family:Avenir;font-size:100%;margin-top:10px;font-size:12px">X</button>
        <button onclick="createF()" class="custom-file-upload" style="left:0;right:0;margin-left:auto;margin-right:auto;font-family:Avenir;font-size:100%;margin-top:10px;font-size:12px;float:right">Create</button>
    </div>
        <div style="width:100%;overflow:hidden;margin:0px;background-color:#d3e5f5;height:100%">

            <div style="background-color:#005194;margin:0px;width:100%;">
                <img width="25px" src="images/MainLogo.png"><h2 style="display:inline;padding:1%;font-family:menuFont;color:whitesmoke;margin:0px;letter-spacing:2px;font-size:100%">MayCome</h2>
            </div>
            <button class="custom-file-upload" style="margin:10px;margin-bottom:0px;margin-top:5px;font-family:Avenir;font-size:100%;float:right;" onclick="back()"><img width="20px" src="images/Back.png"></button>
            <button class="custom-file-upload" style="margin:10px;margin-right:0px;margin-bottom:0px;margin-top:5px;font-family:Avenir;font-size:100%;float:right;" onclick="newf()"><img width="20px" src="images/newFolder.png"></button>
            <label class="custom-file-upload " style="margin:10px;margin-bottom:0px;margin-top:5px;font-family:Avenir;"><img width="20px" src="images/Upload.png">
                <input type="file" onchange="fileLoad()" id="data" name="data" style="border-radius:10px;text-align: center;display:none" multiple/>
            </label>
            <div id="uploadfiles" style="display:none;">
            <h5 id="filesInfo" style="display:inline;font-family:Verdana;font-weight:normal;color:#00335c"></h5>
            <button class="custom-file-upload" style="margin:10px;margin-bottom:0px;margin-top:5px;font-family:Avenir;font-size:100%;" onclick="upload()">Upload</button>
            <div id="percent" style="background-color:#078adb;width:0%;height:10px;margin-top:5px">
            </div>
            </div>


            <div id="addressbar" style="margin:10px;background-color:#005194;border:1px solid #005694;border-radius:5px;padding:3px;padding-left:5px;color:whitesmoke;font-size:13px;overflow-x:scroll;white-space:nowrap;font-family:Verdana">
            </div>
            <div id="dirAreaMain" style="background-color:#edf8ff;border:1px solid #005694;border-radius:5px;height:77vh;margin:10px;overflow-y:scroll;">
                <div id="dirArea" style="display:flex;flex-wrap:wrap;justify-content:space-between">
                </div>
            </div>
        </div>

        <script>
            var dirs;
            var currDir;
            var filesCount;
            getDirectories('');
            document.getElementById("loadingGif").style.display="block";

            function back(){
                 getDirectories(currDir.substring(0,currDir.lastIndexOf("/")))
            }
            function newf(){
                document.getElementById("newFolder").style.display="block";
            }
            function closeNewF(){
                document.getElementById("newFolder").style.display="none";
            }
            function fileLoad(){
                filesCount=document.getElementById("data").files.length;
                document.getElementById("filesInfo").innerHTML=+filesCount+((filesCount==1)? ' file':' files')+" ready for Upload"
                document.getElementById("uploadfiles").style.display="inline";
            }
            function folderClick(index){
                getDirectories(currDir+'/'+dirs.folders[index]);
            }
            function filesClick(index){
              window.open(window.location.origin+window.location.pathname+'/megam/files/'+currDir+'/'+dirs.files[index],"_blank");
            }

            function createF(){
                var fName=document.getElementById("newFname").value
                if(fName==""){
                    alert("Invalid Name")
                }
                else{
                    $.ajax({
                            url:window.location.origin+window.location.pathname+'/megam/newDirectory?password=sanju@1398',
                            type:'post',
                            data:'filePath='+currDir.replace('&','%26')+'/'+fName,
                            success:function(response){
                                alert(response);
                                document.getElementById("newFolder").style.display="none";
                                getDirectories(currDir);
                            },
                             error:function(response){
                                 alert(response);
                                 document.getElementById("loadingGif").style.display="none";
                                 document.getElementById("newFolder").style.display="none";
                             }
                         });
                }
            }

            function getDirectories(path){
                document.getElementById("loadingGif").style.display="block";
                $.ajax({
                    url:window.location.origin+window.location.pathname+'/megam/directory?password=sanju@1398',
                    type:'post',
                    data:'filePath='+path.replace('&','%26'),
                    success:function(response){
                        dirs=JSON.parse(response);
                        dirHtml="";
                        for(var i=0;i<dirs.folders.length;i++){
                            dirHtml=dirHtml+'<div ondblclick="folderClick('+i+')" class="fileContainer"><img src="images/folder.png" width=70% class="center"><div class="filFolders">'+((dirs.folders[i].length<33) ? dirs.folders[i] : dirs.folders[i].substring(0,33)+'...')+'</div></div>'
                            }
                        for(var i=0;i<dirs.files.length;i++){
                            dirHtml=dirHtml+'<div ondblclick="filesClick('+i+')" class="fileContainer"><div style="width:80px;height:60px"><img src="'+window.location.origin+window.location.pathname+'/megam/thumbnail/'+dirs.currDir+'/'+dirs.files[i]+'" onerror="this.onerror=null;this.src=&apos;images/file.png&apos;" style="padding:10px" class="center"></div><div class="filFolders">'+((dirs.files[i].length<23) ? dirs.files[i] : dirs.files[i].substring(0,20)+'...'+dirs.files[i].substring(dirs.files[i].lastIndexOf('.')-4))+'</div></div>'
                        }
                        document.getElementById("dirArea").innerHTML=dirHtml;
                        document.getElementById("dirAreaMain").scrollTop=0;
                        currDir=dirs.currDir;
                        document.getElementById("addressbar").innerHTML=currDir;
                        document.getElementById("loadingGif").style.display="none";
                    },
                     error:function(response){
                         alert(response);
                         document.getElementById("loadingGif").style.display="none";
                     }
             });
            }
        function gett(){
            $.ajax({
                    url:window.location.origin+window.location.pathname+'/megam/murugar01',
                    type:'get',
                    success:function(response){

                                        var binaryString = window.atob(response);
                                        var binaryLen = binaryString.length;
                                        var bytes = new Uint8Array(binaryLen);
                                        for (var i = 0; i < binaryLen; i++) {
                                           var ascii = binaryString.charCodeAt(i);
                                           bytes[i] = ascii;
                                        }

                                    var blob = new Blob([bytes], {type: "application/mp3"});
                                    var link = document.getElementById('lin');
                                    link.href = window.URL.createObjectURL(blob);
                                    var fileName = "Aathadi_Ammadi.mp3";
                                    link.download = fileName;
                    },
                    error:function(response){
                        alert('An error Occured');
                    }
                });

        }

        function upload(){
            var formData=new FormData();
            for(var i=0;i<filesCount;i++){
                formData.append("data",document.getElementById("data").files[i]);
            }
            formData.append("filePath",currDir.replace('&','%26'))
             $.ajax({
                xhr: function()
                      {
                        var xhr = new window.XMLHttpRequest();
                        //Upload progress
                        xhr.upload.addEventListener("progress", function(evt){
                          if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            //Do something with upload progress
                            document.getElementById("percent").style.width=percentComplete*100+'%';
                          }
                        }, false);
                        return xhr;
                      },
                url:window.location.origin+window.location.pathname+'megam/upload?action=upload',
                type:'post',
                data:formData,
                mimeType: "multipart/form-data",
                processData: false,
                contentType: false,
                success:function(response){
                    alert("Files Uploaded");
                    getDirectories(currDir);
                    document.getElementById("uploadfiles").style.display="none";
                },
                error:function(response){
                    alert('An error Occured');
                    document.getElementById("uploadfiles").style.display="none";
                }
            });
            }
    </script>
    </body>
</html>

public class HerokufilesplitController
{
   public Blob file{get;set;}
   public String filename{get; set;}
   public String type{get; set;}
   public String Numberofpage{get; set;}
   public String particularpage{get; set;}
   public Integer radiobuttonvalue{get; set;}
   public Integer splitanynuberofpage{get; set;}
   private String splitpagesize;
   public List<Integer> showtextbox{get; set;}
   private Integer flag;
   public List<Wrapperclass> wrapperclasslist{get ; set;}
   public List<Wrapperclassfortextbox> wrappertextbox{get; set;}
   public Integer secondform{get; set;}
   private Integer flagvalue;
   private String parametervalue;
   private Integer sendfilevalue;
   private List<String> wrapperstringlist;
   private List<String> wrapperfromlist;
   private List<String> wrappertolist;
   public String hidevalue{get; set;}
   private String attchId;
   public String attachId{get; set;}
   public String attachName{get;set;}
   public String baseUrl{get; set;}
   
   public HerokufilesplitController()
   {
        radiobuttonvalue=3;
        secondform=0;
        hidevalue='0';
        flagvalue=0;
        sendfilevalue=0;
        parametervalue='';
        file=blob.valueof('');
     
        //This list use for dynamically generate textbox 
        wrapperclasslist=new List<Wrapperclass>();
        // list use for dynamically generate textbox
        wrapperclasslist.add(new Wrapperclass());
        wrappertextbox=new List<Wrapperclassfortextbox>();
        wrappertextbox.add(new Wrapperclassfortextbox());
        
        wrapperstringlist=new List<String>();
        wrapperfromlist=new List<String>();
        wrappertolist=new List<String>();
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        
    } 
    
    public void savefiel()
    {
        if(!(file.size()<=3000000)) 
        {
         	 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Your can not upload file greater then 3 Mb.')); 
         	 return ;
        }
        secondform=1;
        hidevalue='3';
        
        Herokufileupload__c herokuFileUpload = new Herokufileupload__c();
        herokuFileUpload =[SELECT id FROM Herokufileupload__c WHERE name= 'test' limit 1];
        
        delete[select id from Attachment where parentid = :herokuFileUpload.id ];
        
        //store selected file in attachment
        attachment storefile= new attachment();
        //name of stored file        
        storefile.Name = 'save file.pdf';       
        storefile.ParentId = herokuFileUpload.id;                            
        storefile.body = file; 
        storefile.contentType='application/pdf';
        insert storefile;
        attchId = storefile.id;
        file=blob.valueof('');
        //when file upload in attachment then below message show on page
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Your pdf file '+filename+' uploaded successfully now you can split your pdf file! '));
       
    }
    //when file split sucessfully then list refresh
    public void refreshpage()
    {
         secondform=0;
         hidevalue='0';
         wrappertolist.clear();
         wrapperstringlist.clear();
         wrapperfromlist.clear();
         wrapperclasslist.clear();
         wrappertextbox.clear();
         wrapperclasslist=new List<Wrapperclass>();
         wrapperclasslist.add(new Wrapperclass());
         wrappertextbox=new List<Wrapperclassfortextbox>();
         wrappertextbox.add(new Wrapperclassfortextbox());
    
    }
    public  PageReference Sendfiel()
    {  
    	Attachment Attachfile = new Attachment();
        Attachfile = [select id, name, body,ContentType,BodyLength from Attachment where Id = :attchId limit 1];
        file = Attachfile.body;
        filename = Attachfile.name;
        type = Attachfile.ContentType;
        
        secondform=0;
		//when second  radiobutton selected then this condition  exicute and set number of split page
		if(radiobuttonvalue==1)
       	{
	       splitpagesize='group';
	       parametervalue=Numberofpage;
       
       	}
       	if(radiobuttonvalue==2)
       	{ 
        	//  wrappertextbox.clear();
           	splitpagesize='particular';
           	sendfilevalue=2;
           	for(Wrapperclass record : wrapperclasslist)
           	{
            	wrapperstringlist.add(record.fromvalue); 
           	}    
        }
       	if(radiobuttonvalue==3)
       	{
        	// wrapperclasslist.clear();
           	splitpagesize='range';
           	// parametervalue=wrapperclasslist;
           	sendfilevalue=3;
           
           	for(Wrapperclassfortextbox  fromrecord : wrappertextbox)
           	{
            	wrapperfromlist.add(fromrecord.startvalue); 
               	wrappertolist.add(fromrecord.endvalue);
           	}
       	}
      	if(radiobuttonvalue==0)
      	{
        	splitpagesize='extract';
          	parametervalue='0';
         
      	}
      	// boundary of file  in httprequest
      	String boundary = '----------------------------741e90d31eff';
      	//header of file in httprequest
      	String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+filename+'";\nContent-Type: application/octet-stream';
      	//footer of file
      	String footer = '\r\n--'+boundary+'--';  
      	//headerencoded with base 64            
      	String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
      	//when encoded string end with = then this method encode all string
      	while(headerEncoded.endsWith('='))
      	{
       		header+=' ';
       		headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
      	}
      	//file body encoded with base 64 
       	String bodyEncoded = EncodingUtil.base64Encode(file);
     	String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));

      	Blob bodyBlob = null;
 		//Decode last four byte of file
 		String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
  		if(last4Bytes.endsWith('='))
        {
        	Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
        	HttpRequest tmp = new HttpRequest();
        	tmp.setBodyAsBlob(decoded4Bytes);
        	String last4BytesFooter = tmp.getBody()+footer;   
         	bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded.substring(0,bodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
    	}
      	else
      	{
        	bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
      	}
     	//httprequest for upload file on heroku
     	HttpRequest req = new HttpRequest();
      	//Set header content type
      	req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
     	//send file via post method
     	req.setMethod('POST');
      	if( sendfilevalue==0)
      	{
        	//req.setEndpoint('http://herokufileupload.herokuapp.com/UploadDownloadFileServlet?operationtype='+splitpagesize+'&param1='+parametervalue);
          	req.setEndpoint('https://uploaddownloadfileservlet.herokuapp.com/UploadDownloadFileServlet?operationtype='+splitpagesize+'&param1='+parametervalue);
      	}
      	if( sendfilevalue==2)
      	{
        	req.setEndpoint('https://uploaddownloadfileservlet.herokuapp.com/UploadDownloadFileServlet?operationtype='+splitpagesize+'&param1='+wrapperstringlist);
      	}
       	if( sendfilevalue==3)
      	{
        	req.setEndpoint('https://uploaddownloadfileservlet.herokuapp.com/UploadDownloadFileServlet?operationtype='+splitpagesize+'&param1='+wrapperfromlist+'&param2='+wrappertolist);
      	}
     	//send file body as as blob
      	req.setBodyAsBlob(bodyBlob);
     	req.setTimeout(120000);

      	Http http = new Http();
      	if(!(req.getBodyAsBlob().size()<=3000000)) 
      	{
     	 	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Your can not send file greater then 3 Mb in request.')); 
     	 	return null;
      	}
		try
      	{
        	//Httpresponse for to recive response
          	HTTPResponse res = http.send(req);
          	String result= res.getHeader('result');
         
          	String resultinstring=res.getBody();
         	// String ResponseString=res.getBody();  
          	// when response string contains Blob type then this method called 
         	if(!resultinstring.contains('Please'))
         	{
            	Herokufileupload__c herokuFileUpload = new Herokufileupload__c();
            	herokuFileUpload =[SELECT id FROM Herokufileupload__c WHERE name= 'test' limit 1];
            	//Get body as a blob
            	Blob ResponseString=res.getBodyAsBlob(); 
            	//save file in Attachment
            	attachment DataFile = new attachment();
            	//store file as a zip file        
            	DataFile.Name = 'SplitZipFile.zip';      
            	 
           	 	DataFile.ParentId = herokuFileUpload.id;                            
            	DataFile.body = ResponseString; 
            	DataFile.contentType='application/x-zip-compressed';
            	insert DataFile;   
            	
            	attachId = DataFile.id;
            	attachName = DataFile.Name ;
            	
            	secondform=2;
            	//when file split sucessfully then this message appear 
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Your pdf file split successfully. You can download on below link.')); 
         	}   
         
          	if(resultinstring.contains('Please'))
          	{  
               	refreshpage();
               	secondform=1;
               	hidevalue='3';
               	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, resultinstring));
          	} 
          		radiobuttonvalue=3;
          	}
		catch(Exception ex)
      	{
        	secondform=1;
   		    hidevalue='3';
   		    file=blob.valueof('');
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, ex.getMessage())); 
      	}
        // delete storefile;
        return null;
	}
    
    public void redirect()
    {
    	secondform=1;
    	//  radiobuttonvalue=3;
    }
     //dynamically add textbox
	public  void  Addtextbox()
	{
    	// radiobuttonvalue=3;
    	wrapperclasslist.add(new Wrapperclass());
    }
 	//dynamically remove text box
 	public void Removetextbox()
 	{
    	Integer i=wrapperclasslist.size();
     	if(i!=1)
     	{
     		wrapperclasslist.remove(i-1);
     	}
	}
	//Dynamically add two textbox
	public void Addsecondtextbox()
	{
    	wrappertextbox.add(new Wrapperclassfortextbox());
	}
    //dynamically remove two text box
	public void Removesecondtextbox()
    {
    	Integer i=wrappertextbox.size();
        if(i!=1)
        {
        	wrappertextbox.remove(i-1);
        }
    }
	public class Wrapperclass
    {
    	public String fromvalue{get;set;}
        public Wrapperclass(){}
    }
     
	public class Wrapperclassfortextbox
	{
     	public String startvalue{get; set;}
    	public String endvalue{get; set;}
    	public Wrapperclassfortextbox(){}
    }
}
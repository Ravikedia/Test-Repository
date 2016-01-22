//Please change redirect uri based on application

public class GoogleDriveControllerWithOneButton
{
    //Fetched from URL
    public String code{get;set;} 
    public blob file { get; set; }
   // public String type{get; set;}
    public String filetype{get;set;}
    public  String filename{get; set;}
    
    private string key = '377203344030-0p4f07vdc9jroc211os4ol1a3k6pt9o6.apps.googleusercontent.com' ;
    
    private string secret = 'lkBG8ELh3OoM73li4NPz-5Zk' ;
    private string redirect_uri = 'https://c.ap1.visual.force.com/apex/GoogleDriveWithOneButton' ;
    private String accesstoken ;
    private  Integer expiresIn ;
    private String tokentype;
    public String attchId{get;set;}
    public String redirectURL{get;set;}
    
    public GoogleDriveControllerWithOneButton()
    {
        redirectURL    =    EncodingUtil.urlEncode('https://login.salesforce.com', 'UTF-8');
    }
    
    public PageReference DriveAuth()
    {
       return null; 
    }
 
    
    public void uploadFile(blob doc,string fileName, String accessToken)
    {
  
          string fileType='application/vnd.ms-excel';
          String boundary = '----314159265358979323846';
          String header = '\r\n--' + boundary + '\r\n';
          String footer = '\r\n--' + boundary + '--';
    
          //base64 encoded body 
          String bodyEncoded = EncodingUtil.base64Encode(doc);
   
        String body=header+
       'Content-Type: application/json\r\n\r\n'+
           '{"title" : "'+fileName+'",'+    
           '"mimeType" : "'+fileType+'"}' +
       header+
       'Content-Type: ' + fileType + '\r\n'+
           'Content-Transfer-Encoding: base64\r\n\r\n'+
           bodyEncoded +
           footer; 
 
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer '+accessToken);
         req.setHeader('Content-Type','multipart/related; boundary="'+boundary+'"');  
        req.setHeader('Content-Length',String.valueof(body.length()));
        req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files');
        req.setMethod('POST');
        req.setBody(body);
   
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(res.getBody());
        
        system.debug('+++++++++++++++'+res.getBody());
        system.debug('+++++++++++++++'+rmp);
        //dwnldUrl = string.valueof(rmp.get('webContentLink'));
    }
       
    public void accessToken()
    {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key +'&client_secret='+secret +'&redirect_uri='+redirect_uri +'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));  
        req.setBody(messageBody);  
        req.setTimeout(60*1000);  
  
        Http h = new Http();  
        String resp;
        HttpResponse res = h.send(req);  
        resp = res.getBody();  
        
        ResponseJson actkn = (ResponseJson)JSON.deserialize(resp,ResponseJson.class);
        
        System.debug('@@@@@@@@@@@@@@@@@@@@'+actkn.access_token);
        uploadFile(Blob.valueof('test'), 'test', actkn.access_token);

    }
    
    public class ResponseJson
    {
        public string access_token;
        public String refresh_token; 
        
    }
 
    
}
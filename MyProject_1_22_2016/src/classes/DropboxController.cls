public class DropboxController
{
    //Fetched from URL
    private String code ;
    private String  accesstoken; 
    private String tokentype;
    private String uid;
    public blob file { get; set; }
    public String type{get;set;}
    public  String filename{get; set;}
    
    public DropboxController()
    {
        code = ApexPages.currentPage().getParameters().get('code') ;
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken() ;
        }
    }
    
    public PageReference DropAuth()
    {
        //Authenticating
        PageReference pg = new PageReference('https://www.dropbox.com/1/oauth2/authorize?response_type=code&client_id=clrz68gbh4j3xxq&redirect_uri=https://c.ap1.visual.force.com/apex/salesforce1page&state=Mytesting') ;
        return pg ;
    }
   
    public  PageReference uploadfile()
    {
    
      //String p_fileName =file.Name+'.'+file.Type;
        String p_filename=filename+'.'+type;
        String parent_id = '1121945745';
        String body='';
     // String boundary = 'AaBbCcX30';
     // String boundary = '-------314159265358979323846';
     // String delimiter = '\r\n--" + boundary + "\r\n';
     // String close_delim = '\r\n--" + boundary + "--';
     // String boundary = '__boundary__xxx';
     // String header = '--'+boundary+'\n';
     // body += 'Content-Disposition: form-data; name="data"; filename="'+filename
     // +'"\nContent-Type: application/octet-stream';
     // String footer = '\n--'+boundary+'--';
     // String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\n\n'));
        HttpRequest req = new HttpRequest();

     // String bodyEncoded = EncodingUtil.base64Encode(file);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
     // req.setHeader('Content-Type','multipart/mixed; boundary="'+boundary+'"');
        req.setHeader('Content-Type', 'application/vnd.ms-excel'); 
     // req.setHeader('Content-Encoding','base64');
        req.setHeader('Content-length', String.valueOf(file.size()));                                                                                                                                                                                                             req.setTimeout(60*1000);
        req.setEndpoint('https://api-content.dropbox.com/1/files_put/dropbox/'+filename);
         // req.setEndpoint('https://api.dropbox.com/1/shares/auto/'+filename);
   
        req.setBodyAsBlob(file);
        req.setMethod('POST');
     // req.setTimeout(6000);
        string sUrl = 'https://accounts.google.com';
      //req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
     // req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
     // req.setHeader('Content-Length',String.valueof(body.length()));
      //req.setTimeout(60000);
    //  req.setHeader('Content-Encoding','base64');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('--------------------------'+res.getbody());
        DownloadFile();
        return null;

    }
       
    public void DownloadFile()
    {
        
        System.debug('called');
        // String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\n\n'));
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + accessToken);
       // req.setHeader('Content-Type', 'application/vnd.ms-excel'); 
       // req.setHeader('Content-length', String.valueOf(file.size()));                                                                                                                                                                                                             req.setTimeout(60*1000);
       //below endpoint use for to direct download of uploaded file on dropbox
       // req.setEndpoint('https://api-content.dropbox.com/1/files/auto/'+filename);
       //below link use for to get the link of uploade file on dropbox
        req.setEndpoint('https://api.dropbox.com/1/shares/auto/'+filename);
        //req.setBodyAsBlob(file);
        // req.setMethod('GET');
        req.setMethod('POST');
        Http http=new Http();
        HTTPResponse res = http.send(req);
        System.debug('--------------------------'+res.getbody());

             // string sUrl = 'https://api-content.dropbox.com/1/files/auto/<path>';
             // return null;
    }
    
    public void AccessToken()
    {
        //Getting access token from dropbox
        String tokenuri = 'https://api.dropbox.com/1/oauth2/token?grant_type=authorization_code&code='+code+'&redirect_uri=https://c.ap1.visual.force.com/apex/salesforce1page'; 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenuri);
        req.setMethod('POST');
        req.setTimeout(60*1000);
          
        Blob headerValue = Blob.valueOf('clrz68gbh4j3xxq' + ':' + '26hnyoy64k2rbv7');
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null)
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))
            {
            String fieldName = parser.getText();
            parser.nextToken();
            if(fieldName == 'access_token')
            {
                accesstoken = parser.getText();
            } 
            else if(fieldName == 'uid')
            {
                uid= parser.getText();
            }
            else if(fieldname=='token_type')
            {
                tokentype=parser.getText();
            }
            System.debug('------------------'+accesstoken );
        
            System.debug('--------------------'+tokentype);
            System.debug('--------------------'+uid);
        
        
            System.debug(' You can parse the response to get the access token ::: ' + resp);
   }
   }
   }
   }
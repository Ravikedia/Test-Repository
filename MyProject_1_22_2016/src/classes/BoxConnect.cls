public with sharing class BoxConnect
{
 
    public string valueToShow{get;set;}
    private final string boxClientID = 'eztd0a3u4k8jwwjlq1k4yekbcxzebue0';
    private final string boxSecretCode = 'nFc6TI57h6w43fO28XkoTVf1CC7ZBI2o';
    private final string redirectURI = 'https://c.ap1.visual.force.com/apex/Boxdotcom';
    private string codeFromBox;
    private string accessToken;
    private string refreshToken;
    public Blob file{get; set;}
    public String type{get; set;}
    public String filename{get; set;}
    private String id; 
    private Integer flag;
    
     
    public BoxConnect()
    {
      
        codeFromBox = System.currentPageReference().getParameters().get('code');
        if(codeFromBox == null || codeFromBox == '')
        {
             
        }
        else
        {
            //Try to get a token and then make an API call to Box
            getBoxToken();         
        }
     }
     
    public pageReference boxConnect()
    {
        //Redirect to the OAuth page at Box so the login credentials can be entered.       
        PageReference pr = new PageReference('https://www.box.com/api/oauth2/authorize?' +
            'response_type=code' +
            '&client_id=' + boxClientID +
            '&redirect_uri=' + redirectURI);
        return pr;
    }
    
    public pageReference UploadFile()
    {
      
         String folderId='0';
         String boundary = '----------------------------741e90d31eff';
         String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+filename+'";\nContent-Type: application/octet-stream';
         // GW: Do not prepend footer with \r\n, you'll see why in a moment
         // String footer = '\r\n--'+boundary+'--'; 
         String footer = '--'+boundary+'--';             
         String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
         while(headerEncoded.endsWith('='))
         {
             header+=' ';
             headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
         }
         String bodyEncoded = EncodingUtil.base64Encode(file);
         // GW: Do not encode footer yet
         // String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));

         Blob bodyBlob = null;
         String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
         // GW: replacement section to get rid of padding without corrupting data
         if(last4Bytes.endsWith('=='))
         {
            // The '==' sequence indicates that the last group contained only one 8 bit byte
            // 8 digit binary representation of CR is 00001101
            // 8 digit binary representation of LF is 00001010
            // Stitch them together and then from the right split them into 6 bit chunks
            // 0000110100001010 becomes 0000 110100 001010
            // Note the first 4 bits 0000 are identical to the padding used to encode the
            // second original 6 bit chunk, this is handy it means we can hard code the response in
            // The decimal values of 110100 001010 are 52 10
            // The base64 mapping values of 52 10 are 0 K
            // See http://en.wikipedia.org/wiki/Base64 for base64 mapping table
            // Therefore, we replace == with 0K
            // Note: if using \n\n instead of \r\n replace == with 'oK'
             last4Bytes = last4Bytes.substring(0,2) + '0K';
             bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
             // We have appended the \r\n to the Blob, so leave footer as it is.
             String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
             bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
         } 
         else if(last4Bytes.endsWith('='))
         {
            // '=' indicates that encoded data already contained two out of 3x 8 bit bytes
            // We replace final 8 bit byte with a CR e.g. \r
            // 8 digit binary representation of CR is 00001101
            // Ignore the first 2 bits of 00 001101 they have already been used up as padding
            // for the existing data.
            // The Decimal value of 001101 is 13
            // The base64 value of 13 is N
            // Therefore, we replace = with N
            // Note: if using \n instead of \r replace = with 'K'
            last4Bytes = last4Bytes.substring(0,3) + 'N';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            // We have appended the CR e.g. \r, still need to prepend the line feed to the footer
            footer = '\n' + footer;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);              
          } 
          else
          {
              // Prepend the CR LF to the footer
              footer = '\r\n' + footer;
              String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
              bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
          }

              String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+folderId;
              HttpRequest req = new HttpRequest();
              req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
              req.setMethod('POST');
              req.setEndpoint(sUrl);
              req.setBodyAsBlob(bodyBlob);
              req.setTimeout(60000);
              req.setHeader('Authorization', 'Bearer '+accesstoken);
              req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
              Http http = new Http();
              HTTPResponse res = http.send(req);
              String s=res.getBody();
              System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+s);
              
            JSONParser parser = JSON.createParser(res.getBody());
            flag=1;
            while (parser.nextToken() != null)
             {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME)
            {
                
                if(parser.getText()=='id' && flag==1)
                {
                     parser.nextToken();
                     id= parser.getText();
                     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+id);
                     flag=2;
                     break;
                }
            }
             
             } 
              
             // parseAuthJSON(res.getBody());
              if(flag==2)
              {
                   DownloadFile();
              }
              return null;

   }
    public void DownloadFile()
    {
          // String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+folderId;
            /*  HttpRequest req = new HttpRequest();
              //req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
             // Endpoint('https://api.box.com/2.0/folders/0/items?limit='+EncodingUtil.urlEncode('5','UTF-8')+'&offset='+EncodingUtil.urlEncode('0','UTF-8'));
              req.setMethod('GET');
              req.setEndpoint('https://api.box.com/2.0/folders/0/items?limit='+EncodingUtil.urlEncode('5','UTF-8')+'&offset='+EncodingUtil.urlEncode('0','UTF-8'));
             // req.setBodyAsBlob(bodyBlob);
              req.setTimeout(60000);
              req.setHeader('Authorization', 'Bearer '+accesstoken);
             // req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
              Http http = new Http();
              HTTPResponse res = http.send(req);
              String s=res.getBody();
              System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+s);*/
              
            //  String id='19587842553';
              System.debug('ID is:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'+id);
                    System.debug('ID is:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'+accesstoken);
              Http hh = new Http();
              HttpRequest request = new HttpRequest();
              string endPointValue = 'https://api.box.com/2.0/files/';
              endPointValue=endPointValue+id+'/content';
              request .setEndpoint(endPointValue);
              request .setMethod('GET');
              request .setHeader('Authorization', 'Bearer '+accesstoken);
              HttpResponse response = hh.send(request );
              system.debug('pANYaaaaaaaaaaaaaaaaaaaaaaaaaaaa'+response .getBody());
              system.debug('pANYaaaaaaaaaaaaaaaaaaaaaaaaaaaa'+response .getHeader('Location'));
            //  return res.getHeader('Location');

             

    }
    public void checktokenvaliditytime()
    {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://www.box.com/api/oauth2/tokeninfo';
        req.setEndpoint(endPointValue);
        req.setMethod('GET');
        HttpResponse res = h.send(req);   
        System.debug('************************************************'+res.getBody());
            
    
    }
        
   
    private void getBoxToken()
    {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endPointValue = 'https://www.box.com/api/oauth2/token';
        req.setEndpoint(endPointValue);
        req.setBody('Content-Type=' + EncodingUtil.urlEncode('application/x-www-form-urlencoded', 'UTF-8') +
                    '&charset=' + EncodingUtil.urlEncode('UTF-8', 'UTF-8') +
                    '&grant_type=' + EncodingUtil.urlEncode('authorization_code', 'UTF-8') +
                    '&code=' + EncodingUtil.urlEncode(codeFromBox, 'UTF-8') +
                    '&client_id=' + EncodingUtil.urlEncode(boxClientID, 'UTF-8') +
                    '&client_secret=' + EncodingUtil.urlEncode(boxSecretCode, 'UTF-8') +
                    '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8'));
                    
        req.setMethod('POST');
        HttpResponse res = h.send(req);
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+res.getBody());
        parseAuthJSON(res.getBody());
        checktokenvaliditytime();
          
    }
    
    private void parseAuthJSON(string JSONValue)
    {
        JSONParser parser = JSON.createParser(JSONValue);
        accessToken = '';
        refreshToken = '';
      
        flag=1;
        while (parser.nextToken() != null)
        {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME)
            {
                if(parser.getText() == 'access_token')
                {
                    parser.nextToken();
                    accessToken = parser.getText();
                    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+accessToken);
                }
                if(parser.getText() == 'refresh_token')
                {
                    parser.nextToken();
                    refreshToken = parser.getText();
                     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+refreshToken );
                }
                if(parser.getText()=='id' && flag==1)
                {
                 parser.nextToken();
                    id= parser.getText();
                     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+id);
                     flag=2;
                
                }
            }
            
            if(accessToken != '' && refreshToken != ''){
                break;
            }
        }
    }
     
}
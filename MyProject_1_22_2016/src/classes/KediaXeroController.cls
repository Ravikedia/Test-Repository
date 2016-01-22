public class KediaXeroController
{
       //Fetched from URL
    private String code ;
    public blob file { get; set; }
   // public String type{get; set;}
    public String filetype{get;set;}
    public  String filename{get; set;}
    
    private string consumer_key= '03TWOMPJAKMHXCWNIIUKGHYFIN62FB' ;
    
    private string secret = 'NXSBTSMZPFMSLQMGDXJHIQKX4TCZHC' ;
    private string redirect_uri = 'https://c.ap1.visual.force.com/apex/KediaXero' ;
    private String accesstoken ;
    private  Integer expiresIn ;
    private String tokentype;
    
      
    public KediaXeroController()
    {
        code = ApexPages.currentPage().getParameters().get('code') ;
        System.debug('----------------------------------------------------------------'+code);
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            //AccessToken() ;
        }
    }
    
    
    public PageReference authenticate()
    {
        //Authenticating
        PageReference pg = new PageReference(Authentication(consumer_key, redirect_uri)) ;
        return pg ;
    }
    
    
    public String Authentication(String Clientkey,String redirect_uri)
    {
       
       /*String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
         String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
         String authuri = '';
         authuri = 'https://api.xero.com/oauth/Authorize'+
        'client_id='+key+
        '&response_type=code'+
        '&scope=https://api.xero.com/oauth/Authorize'+
        '&redirect_uri='+uri+
        '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+
        '&login_hint=jsmith@example.com&'+
        'access_type=offline';
         return authuri;*/
        
        Http h = new Http();
        String consumer_key='03TWOMPJAKMHXCWNIIUKGHYFIN62FB';
        Long tmp=(System.now().getTime()/1000);
        
        Blob isItCorrect = Crypto.generateMac('HMacSHA1', Blob.valueOf('https://api.xero.com/api.xro/2.0'), Blob.valueOf(consumer_key));
        String signature= EncodingUtil.urlEncode(EncodingUtil.base64Encode(isItCorrect), 'UTF-8');
        
        // Try to get access token
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.xero.com/oauth/Authorize?oauth_consumer_key='+consumer_key+
            '&oauth_signature_method=RSA-SHA1'+
            '&oauth_signature='+signature+
            '&oauth_timestamp='+tmp+ '&oauth_nonce='+tmp+'&oauth_version=1.0&scope=https%3A%2F%2Fapi.xero.com%2Fapi.xro%2F2.0');
        req.setMethod('GET');
        
       //Send the request, and return a response
        HttpResponse res = h.send(req);
        System.debug('##################'+res.getBody());
        return res.getBody();
    }
       
          

}
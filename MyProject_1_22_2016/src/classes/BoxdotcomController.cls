public Class  BoxdotcomController
{
   
   String code;
   String client_id;
   String client_secret;
   String redirect_uri;
    public BoxdotcomController()
    {
        
        client_id='eztd0a3u4k8jwwjlq1k4yekbcxzebue0';
        
       
        client_secret='nFc6TI57h6w43fO28XkoTVf1CC7ZBI2o';
        redirect_uri='https://c.ap1.visual.force.com/apex/Boxdotcom';
        code = ApexPages.currentPage().getParameters().get('code') ;
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken() ;
        }
    
    }
      public PageReference BoxAuth()
     {
        //Authenticating
        PageReference pg = new PageReference('https://www.box.com/api/oauth2/authorize?response_type=code&client_id='+client_id+'&redirect_uri='+redirect_uri+'&state=security_token%3DKnhMJatFipTAnM0nHlZA') ;
        return pg ;
     }                                                                                                                                               
    
    
     public void AccessToken()
    {
        //Getting access token from dropbox
        
        System.debug('client id isssssssssssssssssssssssssssss'+client_id+'secret isssssssssssssssssssssssssssssssss'+client_secret);
        String tokenuri ='https://www.box.com/api/oauth2/token?grant_type=authorization_code&code='+code+'&client_id='+client_id+'&client_secret='+client_secret; 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenuri);
        req.setMethod('POST');
        Blob headerValue = Blob.valueOf('clrz68gbh4j3xxq' + ':' + '26hnyoy64k2rbv7');
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
      
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        System.debug('Shree Ganeshya namah::::::::::::::::::::::::::::::::::::::::::::::::::::::::'+resp);
        
    }
    
}
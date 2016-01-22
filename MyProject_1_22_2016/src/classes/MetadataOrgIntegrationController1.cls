public with sharing class MetadataOrgIntegrationController1
{
    private String key = '3MVG9Y6d_Btp4xp6vKjKNoumuYfV_lxtm.K4qgYpOsgN3hg5o6IBuwj0fbblGF1MaH6ddFTTBv0YxCpvKeUeA';
    private String clientSecret = '1531512294065301649';
    private String username='kediaraviapex1@gmail.com';
    private String password='7597114512AAAAA';
    //private string redirect_uri = 'https://ap1.salesforce.com/services/oauth2/token';
    private string redirect_uri = 'https://c.ap1.visual.force.com/apex/clientSearchPage';
    private String code ;
    
    public String accessToken {get; set;}
    
    
    public MetadataOrgIntegrationController1()
    {
        code = ApexPages.currentPage().getParameters().get('code') ;
        System.debug('----------------------------------------------------------------'+code);
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken() ;
        }
    }
    
    public PageReference DriveAuth()
    {
        //Authenticating
        PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;
        return pg ;
    }
    public void AccessToken()
    {
       
       /* POST /services/oauth2/token HTTP/1.1
        Host: login.salesforce.com 
        grant_type=authorization_code&code=aPrxsmIEeqM9PiQroGEWx1UiMQd95_5JUZ
        VEhsOFhS8EVvbfYBBJli2W5fn3zbo.8hojaNW_1g%3D%3D&client_id=3MVG9lKcPoNI
        NVBIPJjdw1J9LLM82HnFVVX19KY1uA5mu0QqEWhqKpoW3svG3XHrXDiCQjK1mdgAvhCs
        cA9GE&client_secret=1955279925675241571&
        redirect_uri=https%3A%2F%2Fwww.mysite.com%2Fcode_callback.jsp*/
       
        String reqbody = 'grant_type=authorization_code&code='+code+'&client_id='+key+'&client_secret='+clientSecret+'&redirect_uri=https://c.ap1.visual.force.com/apex/clientSearchPage';
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+reqbody);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://ap1.salesforce.com/services/oauth2/token');//Note if my domain is set up use the proper domain name else use login.salesforce.com for prod or developer or test.salesforce.com for sandbox instance
  
        HttpResponse res = h.send(req);
         
        system.debug('@@@@@@@@@@@@@@@@@@@@'+res.getbody());
        OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);

      if(objAuthenticationInfo.access_token!=null) {
       system.debug('RESPONSE_BODY'+objAuthenticationInfo.access_token);
       accessToken = objAuthenticationInfo.access_token;
      }
    
    }
    
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri)
    {
        String authuri = '';
        authuri = 'https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id='+Clientkey+'&redirect_uri=https://c.ap1.visual.force.com/apex/clientSearchPage&state=mystate';
        return authuri;
    }
    
    /*public MetadataOrgIntegrationController()
    {
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+reqbody);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint(redirect_uri);//Note if my domain is set up use the proper domain name else use login.salesforce.com for prod or developer or test.salesforce.com for sandbox instance
  
        HttpResponse res = h.send(req);
  
        OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);

      if(objAuthenticationInfo.access_token!=null) {
       system.debug('RESPONSE_BODY'+objAuthenticationInfo.access_token);
       accessToken = objAuthenticationInfo.access_token;
      }
    }
    */
    public void externaldata()
    {
        system.debug('@@@@@@@@@@@@@@@'+accessToken);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://ap1.salesforce.com/services/data/v20.0/query/?q=SELECT+name+from+Account');
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setMethod('GET');
        req.setTimeout(60*1000);
        
        Http http = new Http();
        HttpResponse resp = http.send(req);
        system.debug('::::::::::::::::::::1111:::::::::::::::::::::'+resp.getbody());
    }
    
    public class OAuth2{
      public String id{get;set;}
      public String issued_at{get;set;}
      public String instance_url{get;set;}
      public String signature{get;set;}
      public String access_token{get;set;}    
     }
}
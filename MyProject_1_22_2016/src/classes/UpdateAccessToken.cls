public class UpdateAccessToken
{
    public UpdateAccessToken()
    {
    
    }
    
    public void UpdateAccessToeknUsingRefreshToken()
    {
    
        Credentials__c credentials = Credentials__c.getOrgDefaults();
        List<AuthorizationDetails__c> authDetailsList = [SELECT AuthorisedUser__c,instanceURL__c,refreshToken__c,AccessToken__c FROM AuthorizationDetails__c WHERE AuthorisedUser__c = 'kediaraviapex2@gmail.com' limit 1];
        if(authDetailsList.size() > 0)
        {
            String endpoint = 'https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token'+
                      '&refresh_token='+authDetailsList[0].refreshToken__c+
                      '&client_id='+credentials.ConsumerKey__c+
                      '&client_secret='+credentials.ConsumerSecret__c;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            Http h = new Http();
            HttpResponse res= h.send(req);
            if(res != null) 
            {
                String response = res.getBody();
                if(res.getStatusCode() == 200)
                {
                    String accessToken = getValue(response, 'access_token');
                    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@'+accessToken );
                  //  return accessToken;
                }
            }
        }
        
        
       // return null;
    }
    
    private String getValue(String response, String key)
    {
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(response);
        return (String)params.get(key);
    }
}
public with sharing class RegisterOrganizationController 
{
	public String userName {get;set;}
	public String authorizationCode {get;set;}
	public String loginUrl {get;set;} 
	private Credentials__c credentials = Credentials__c.getOrgDefaults();
	
	public String erroMsg {get;set;} 
	
   	public RegisterOrganizationController()
   	{
   		processLogin();
   	}
   	
   	public void checkAndSave()
   	{
   		if(authorizationCode != null && authorizationCode != '')
   		{
   			String endpoint = 'https://login.salesforce.com/services/oauth2/token?grant_type=authorization_code'+
            '&redirect_uri='+EncodingUtil.urlEncode('oob','UTF-8')+
            '&code='+EncodingUtil.urlEncode(authorizationCode,'UTF-8')+
            '&client_id='+credentials.ConsumerKey__c+
            '&client_secret='+credentials.ConsumerSecret__c;
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            Http h = new Http();
            String resp;
            HttpResponse res = h.send(req);
            if(res != null)
            {
                String response = res.getBody();
                if(res.getStatusCode() == 200)
                {
                	erroMsg = '';
                    String InstanceUrl = getValue(response,'instance_url');
            		String RefereshToken = getValue(response,'refresh_token');
            		String AccessToken = getValue(response,'access_token');
            		String sfid = getValue(response,'id');
            		res = sendRequestWithToken(sfid.replace('https://login.salesforce.com', InstanceUrl),AccessToken);
            		if(res != null &&  res.getStatusCode() == 200)
            		{
            			response = res.getBody();
            			String OrgUserName = getValue(response,'username');
                		String UserFullName = getValue(response,'display_name');
                        String OrganisationId = getValue(response,'organization_id');
                        
                        List<AuthorizationDetails__c> authDetailsList = [SELECT AuthorisedUser__c,instanceURL__c,refreshToken__c,AccessToken__c FROM AuthorizationDetails__c WHERE AuthorisedUser__c =: OrgUserName limit 1];
                        if(authDetailsList.size() > 0)
                        {
	                        authDetailsList[0].instanceURL__c = InstanceUrl;
	                        authDetailsList[0].refreshToken__c = RefereshToken;
	                        authDetailsList[0].AccessToken__c = AccessToken;
	                        update authDetailsList;
                        }
                        else
                        {
                        	AuthorizationDetails__c authDetails = new AuthorizationDetails__c();
                        	authDetails.name = OrganisationId;
	                        authDetails.AuthorisedUser__c = OrgUserName;
	                        authDetails.instanceURL__c = InstanceUrl;
	                        authDetails.refreshToken__c = RefereshToken;
	                        authDetails.AccessToken__c = AccessToken;
	                        insert authDetails; 
                        }
                        erroMsg = '';
            		}
            		else
            		{
            			erroMsg = 'Something went wrong please try again.';
            		}
               }
               else
               {
               		erroMsg = 'Invalid authorization code.';
               }
           }
   		}
   	}
   	
   	public void processLogin()
    {
        loginUrl = 'https://login.salesforce.com/services/oauth2/authorize?response_type=code'+
                  '&client_id='+credentials.ConsumerKey__c+
                  '&redirect_uri='+credentials.redirect_url__c+'&state=mystate';
    }
    
    private HttpResponse sendRequestWithToken(String endpoint, String token)
    {
    	try
        {
        	HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setHeader('Authorization', 'Bearer '+token);
            req.setMethod('GET');
            Http h = new Http();
            String resp;
            HttpResponse res = h.send(req);
            return res;
        }
        catch(System.CalloutException ex)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
        }
        return null;
    }
    
    private String getValue(String response, String key)
    {
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(response);
        return (String)params.get(key);
    }
}
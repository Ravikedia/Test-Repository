public class OAuthController
{
	public String service { get; set; }
	//Services Picklist
	String message=null;
	private static List<selectOption> VIEW_SERVICES = new SelectOption[]{

	new SelectOption('Facebook','Facebook')

	};
	public List<SelectOption> getServiceNames(){
	return VIEW_SERVICES;
	}
	public String getMessage(){
	return message;
	}
	public PageReference finalAuth(){
	//OAuth_1_0 oa = new OAuth_1_0('Twitter');
	String oauth_token = ApexPages.currentPage().getParameters().get('oauth_token');
	String oauth_verifier = ApexPages.currentPage().getParameters().get('oauth_verifier');
	String oauth_code = ApexPages.currentPage().getParameters().get('code');
 
	//message=oauth_token+' '+oauth_verifier;
	//Now call auth service to get authorized tokens
	if (oauth_code != null){
    oauth_code = oauth_code+'#_=_'; //Facebook anomaly?
    UserTokens__c userToken = [select Id,OAuth_Service__c,Token__c,secretToken__c from UserTokens__c
                              where isAuthorized__c = false and CreatedBy.Name=:userInfo.getName()];
    OAuth_Service__c oservice = [select Name,AccessTokenUrl__c from OAuth_Service__c
                                where Id = :userToken.OAuth_Service__c LIMIT 1];
                                
                                System.debug('------oservice--------------'+oservice.Name);
    OAuth_2_0 oa = new OAuth_2_0(oservice.Name);
    String authorizedStr=oa.getAuthorizedReqToken(oauth_code);
    String authUserToken=authorizedStr.split('&')[0].split('=')[1];
    //String authUserToken=authorizedStr;
    userToken.Token__c = authUserToken;
    userToken.isAuthorized__c = true;
    upsert userToken;
    message='Authorization Successful..'+'Access Token:'+authUserToken;
	}
	return null;
    }
	public PageReference doAuthorization(){
	//This is a 2 Legged authorization
	// Get UnAuthorized Tokens
	System.debug('========================== Service:'+service);
	PageReference authPage;
	OAuth_Service__c os = [select Id,Name,OAuth_Version__c,ReqTokenUrl__c,AuthUrl__c from OAuth_Service__c limit 1];
	if (os.OAuth_Version__c != NULL && os.OAuth_Version__c.equalsIgnoreCase('2.0')){
    List<UserTokens__c> unauthorizedTokenList=[select Id from UserTokens__c
                                               where CreatedBy.Name=:userInfo.getName()
                                               and OAuth_Service__c = :os.Id];
    delete unauthorizedTokenList;
    OAuth_2_0 oa = new OAuth_2_0(service);
    System.debug('no i am calling');
    UserTokens__c userToken = new UserTokens__c();
    userToken.Name = service+' '+userInfo.getName();
    userToken.OAuth_Service__c = os.Id;
    userToken.isAuthorized__c = false;
    insert userToken;
    String authURL = oa.getUnauthorizedReqToken();
    authPage=new PageReference(authURL);
    authPage.setRedirect(true);
	}
	return authPage;
	}
	}
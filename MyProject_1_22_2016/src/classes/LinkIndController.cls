public class LinkIndController
{
    //Fetched from URL
    private String code ;
    public blob file { get; set; }
    public String filetype{get;set;}
    public  String filename{get; set;}
    private string key = '' ;
    private string secret = '' ;
    private string redirect_uri = '';
    private String accesstoken ;
    private  Integer expiresIn ;
    private String tokentype;
    public List<WrapperClassForPersonalInformation> personalInformation{get; set;}
    public String candidateName{get; set;}
    
    public LinkIndController()
    {
        List<Authorization_Detail__c> mcs = Authorization_Detail__c.getall().values();
        key = mcs[0].Key__c;
        secret = mcs[0].secret__c;
        redirect_uri = mcs[0].redirect_uri__c;
        
        code = ApexPages.currentPage().getParameters().get('code') ;
        personalInformation = new List<WrapperClassForPersonalInformation>();
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
    
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri)
    {
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = 'https://www.linkedin.com/uas/oauth2/authorization?response_type=code'+
                                           '&client_id='+key+
                                           '&scope=r_fullprofile%20r_emailaddress%20r_network%20r_basicprofile%20r_network%20r_contactinfo%20rw_nus%20rw_groups%20w_messages'+
                                           '&state=DCEEFWF45453sdffef424'+
                                           '&redirect_uri='+uri;
                                            return authuri;
    }
    
    public void AccessToken()
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code'+
                                           '&code='+code+
                                           '&redirect_uri='+redirect_uri+
                                           '&client_id='+key+
                                           '&client_secret='+secret);
        req.setTimeout(60*1000);
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
		            accesstoken = parser.getText();
		        else if(fieldName == 'expires_in')
		            expiresIn = parser.getIntegerValue();
		        else if(fieldname=='token_type')
		            tokentype=parser.getText();
	        }
		 }
  	}
  	
    public void getPeopleInformation()
 	{
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.linkedin.com/v1/people/~'+
        ':(first-name,last-name,headline,location,distance,num-connections,picture-url,positions,public-profile-url)?format=json&oauth2_access_token=' + accesstoken);
   
        // req.setEndpoint('https://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name)?format=json&oauth2_access_token=' + accesstoken);
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?format=json&oauth2_access_token=' + accesstoken);
        
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?first-name=Tushar&last-name=sharma&format=json&oauth2_access_token='+accesstoken);
        
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?school-name=Shermer%20High%20School&current-school=false&format=json&oauth2_access_token='+accesstoken);
          
   		req.setMethod('GET');
       	HttpResponse res = null;
      	http h= new Http();
       	res= h.send(req);
       	parseString(res.getbody());
     
 	}
 	
 	public void getConnectionInformation()
 	{	
 		HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.linkedin.com/v1/people/~/connections'+
         ':(first-name,last-name,headline,location,distance,num-connections,picture-url,positions,public-profile-url)?format=json&oauth2_access_token=' + accesstoken); 
            
        // req.setEndpoint('https://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name)?format=json&oauth2_access_token=' + accesstoken);
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?format=json&oauth2_access_token=' + accesstoken);
        
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?first-name=Tushar&last-name=sharma&format=json&oauth2_access_token='+accesstoken);
        
        // req.setEndpoint('https://api.linkedin.com/v1/people-search?school-name=Shermer%20High%20School&current-school=false&format=json&oauth2_access_token='+accesstoken);
          
   		req.setMethod('GET');
       	HttpResponse res = null;
      	http h= new Http();
       	res= h.send(req);
       	parseString(res.getbody());	
 	}
 	
 	public void SearchPerson()
 	{
			HttpRequest req = new HttpRequest();
			//req.setEndpoint('https://api.linkedin.com/v1/people/~/job-bookmarks?format=json&oauth2_access_token=' + accesstoken);
			
			//req.setEndpoint('https://api.linkedin.com/v1/people-search?first-name=Clair&format=json&oauth2_access_token=' + accesstoken);
			//req.setEndpoint('https://api.linkedin.com/v1/people-search?school-name=Shermer%20High%20School&format=json&oauth2_access_token=' + accesstoken);
			req.setEndpoint('https://api.linkedin.com/v1/people-search:(people:(id))?first-name=bill&last-name=gates&format=json&oauth2_access_token=' + accesstoken);
			req.setMethod('GET');
       		HttpResponse res = null;
      		http h= new Http();
       		res= h.send(req);
       		//parseString(res.getbody());
       		System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+res.getbody());
 	}
 	
 	public void parseString(String str)
 	{
 		String firstName = '';
    	String lastName ='';
    	String headline ='';
    	String title = '';
    	String publicProfileUrl ='';
    	String pictureUrl = '';
    	personalInformation = new List<WrapperClassForPersonalInformation>();
 		JSONParser parser = JSON.createParser(str);
       	while (parser.nextToken()  != null)
     	{
        	if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
          	{
            	String text = parser.getText();
                if (parser.nextToken() != JSONToken.VALUE_NULL)
                {
	                if(text == 'firstName')
                    	firstName = parser.getText();
                    else if (text == 'lastName')
                    	lastName = parser.getText();
                    else if (text == 'headline')
                    	headline = parser.getText();
                    else if(text == 'title')
                    	title = parser.getText();
                    else if(text == 'publicProfileUrl' )
                    	publicProfileUrl = parser.getText();
                    else if (text == 'pictureUrl')
                    	pictureUrl = parser.getText();
                    
                    if(firstName != '' && lastName != '' && headline != '' && title != '' && publicProfileUrl != '')
                    {
                    	personalInformation.add(new WrapperClassForPersonalInformation(firstName,lastName, headline, title, publicProfileUrl, pictureUrl));
                    	firstName = '';  lastName = '' ; headline = ''; title = ''; publicProfileUrl = ''; pictureUrl = '';
                    } 
                }
          	}
    	}
 	}
 	
 	
	public class WrapperClassForPersonalInformation
 	{  
    	public String firstName{get;set;}
    	public String lastName{get; set;}
    	public String headline{get; set;}
    	public String title{get; set;}
    	public String publicProfileUrl{get; set;}
    	public String pictureUrl{get; set;}
    	
    	public WrapperClassForPersonalInformation(String firstName, String lastName,String headline , String title, String publicProfileUrl, String pictureUrl)
    	{
        	this.firstName = firstName;
        	this.lastName = lastName; 
        	this.headline = headline;
        	this.title = title;
        	this.publicProfileUrl = publicProfileUrl;
        	this.pictureUrl = pictureUrl;
    	} 
 	}

}
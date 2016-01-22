public with sharing class MetadataOrgIntegrationController
{
    //Uat org
   /* private String key = '3MVG9WtWSKUDG.x4QNV6jjiFN03NUF3UCVYunLlaO8VkT8bXOgLa0tXE2VORhsWvkQOWaDGttIJltB9uyG.CR';
    private String clientSecret = '7402756221886745956';*/

    
     //Packaging org
    //  private String key = '3MVG9Rd3qC6oMalWzrH_IRkDYn1BVoh_YJAjbVcoCTLGaK5DSwrY1XBH43XeTHmEgzPgjEnLIL1VxYSzdcX88';
     // private String clientSecret = '5260804689656883405';
  
    
    // private String key= '3MVG9WtWSKUDG.x4QNV6jjiFN06XHjR1HOrtWYKsxcmjcWnhqk9khZ.FIIfsFMjmRt54pBtrl0WIaJ3g6ySy4';
    // private String clientSecret = '4480368747121611627';
    
    //private string redirect_uri = 'https://c.eu5.visual.force.com/apex/ClientSearch';
    
    //self
     private String key = '3MVG9Rd3qC6oMalWcenfNv3REXXnOlNPKqheaWDTc02W_TWNDbjkGsi3bCYdqqZrA6zZJZBUJSwsqj_Lpvkul';
     private String clientSecret = '3613323904957598145';
    
    
    private string redirect_uri = 'oob';
    public List<Client__c> listOfAccount{get;set;}
    public String loginUrl {get;set;} 
    private String instanceType;
    public String baseurl{get;set;}
    
    public String clientFName {get;set;}
    public String clientLName {get;set;}
    private Transient List<Client__c> clientList = new List<Client__c>();
    public List<ClientWrapper> clientWrap {get;set;}

   // private string redirect_uri = 'https://emea.salesforce.com/services/oauth2/token';
    

    public String accessToken {get; set;}
    private String code ;
    
    public String password{get;set;}
    
    public MetadataOrgIntegrationController()
    {
        listOfAccount = new List<Client__c>();
        password = '';
        AccessToken ='';
        clientWrap = new List<ClientWrapper>();
    }

   
   public void processLogin()
   {
       // this.instanceType = /*this.organizationRecord.Organisation_Type__c == 'Sandbox' ? 'https://test.salesforce.com' : 'https://login.salesforce.com';*/
       this.instanceType  = 'https://login.salesforce.com';
       loginUrl = this.instanceType+'/services/oauth2/authorize?response_type=code'+
                  '&client_id='+key+
                  '&redirect_uri='+redirect_uri+'&state=mystate';
   }

    public void AccessToken()
    {
    }
    
    private String getValue(String response, String key)
    {
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(response);
        return (String)params.get(key);
    }
    
    public void externaldata()
    {    
        if(AccessToken =='' )
        {
             String endpoint = 'https://login.salesforce.com/services/oauth2/token?grant_type=authorization_code'+
            '&redirect_uri='+EncodingUtil.urlEncode('oob','UTF-8')+
            '&code='+EncodingUtil.urlEncode(password,'UTF-8')+
            '&client_id='+key+
            '&client_secret='+clientSecret;
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            Http h = new Http();
            String resp;
            HttpResponse res = h.send(req);
            system.debug('#############################'+res.getBody());
            if(res != null)
            {
                String response = res.getBody();
                if(res.getStatusCode() == 200)
                {
                    String InstanceUrl = getValue(response,'instance_url');
                    String RefereshToken = getValue(response,'refresh_token');
                    AccessToken = getValue(response,'access_token');
                    String orgid= getValue(response,'id');
                    system.debug('::::::::::::::::::::1111:::::::::::::::::::::'+InstanceUrl);
                    system.debug('::::::::::::::::::::1111:::::::::::::::::::::'+RefereshToken);
                    system.debug('::::::::::::::::::::1111:::::::::::::::::::::'+AccessToken);
                    baseurl = InstanceUrl;
                      
               }
           }
        }
        if(AccessToken !='' )
        {
            reteriveData();
        }
    }
    
    public void reteriveData()
    {
        clientWrap = new List<ClientWrapper>();
        try
        {
            system.debug('########################################################'+AccessToken);
            RetrieveClients.GetClientDataWebService rc = new RetrieveClients.GetClientDataWebService();
            RetrieveClients.SessionHeader_element  ss= new RetrieveClients.SessionHeader_element();
            ss.sessionId = AccessToken;
            rc.SessionHeader = ss;
            clientFName = 'Test';
            clientLName = 'Client';
            clientWrap = (List<ClientWrapper>)JSON.deserialize(rc.retrieveClientData(clientFName,clientLName), List<ClientWrapper>.class);
            system.debug('########################################################'+clientWrap);     
         }
         catch(Exception e)
         {
             system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+e.getmessage());
         }
        /*  HttpRequest req1 = new HttpRequest();
        String str  = 'Heather';
        //req.setEndpoint('https://emea.salesforce.com/services/data/v20.0/query/?q=SELECT+id,+First_Name__c,+Last_Name__c,+Full_Name__c+from+Client__c');
        
        req1.setEndpoint(baseurl+'/services/data/v20.0/query/?q=SELECT+id,+CJS_Cahoot__First_Name__c,+CJS_Cahoot__Last_Name__c,+CJS_Cahoot__Full_Name__c+from+CJS_Cahoot__Client__c');
        
        //req1.setEndpoint('https://eu5.salesforce.com/services/data/v20.0/query/?q=SELECT+id,+First_Name__c,+Last_Name__c,+Full_Name__c+from+Client__c');
        
        
        //req.setEndpoint('https://login.salesforce.com/services/data/v20.0/query/?q=SELECT+id,+First_Name__c,+Last_Name__c,+Full_Name__c+from+Client__c');
        
        req1.setHeader('Authorization', 'Bearer ' +AccessToken);
        req1.setMethod('GET');
        req1.setTimeout(60*1000);
        
        Http http1 = new Http();
        HttpResponse resp1 = http1.send(req1);
        system.debug('::::::::::::::::::::1111:::::::::::::::::::::'+resp1.getbody());
        
       /* JSONParser parser = JSON.createParser(resp1.getbody());  
        Integer i=0;

        listOfAccount = new List<Client__c>();
        String clientName= '';
        String lastName = '';
        String fullName = '';
        while (parser.nextToken() != null)
        {  
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
            {
                String fieldName = parser.getText();
                
                if (fieldName == 'CJS_Cahoot__First_Name__c')
                {
                    system.debug('Client record Name => ' + parser.getText());
                    system.debug('Client record Name => ' + parser.nextToken());
                    clientName = parser.getText();
                   
                }
                else if(fieldName == 'CJS_Cahoot__Last_Name__c')
                {
                    system.debug('Client record Name => ' + parser.nextToken());
                    lastName  = parser.getText();
                }
                else if(fieldName == 'CJS_Cahoot__Full_Name__c')
                {
                    fullName  =   parser.getText();
                    i=1;
                }
                else if(fieldName  == 'First_Name__c' )
                {
                    system.debug('Client record Name => ' + parser.getText());
                    system.debug('Client record Name => ' + parser.nextToken());
                    clientName = parser.getText();
                }
                else if(fieldName  == 'Last_Name__c' )
                {
                    system.debug('Client record Name => ' + parser.nextToken());
                    lastName  = parser.getText();
                    i=1;
                }
                
                if(i == 1)
                {
                    Client__c clnt = new Client__c();
                    clnt.First_Name__c = clientName;
                    clnt.Last_Name__c = lastName  ;
                    //clnt.Full_Name__c = fullName ;
                    listOfAccount .add(clnt);
                    i=0;
                    
                }
            }
            
        }*/
        
    
    }
    public class OAuth2
    {
      public String id{get;set;}
      public String issued_at{get;set;}
      public String instance_url{get;set;}
      public String signature{get;set;}
      public String access_token{get;set;}    
    }
    
    public class ClientWrapper
    {
        public String fName {get;set;}
        public String lName {get;set;}
        
        public ClientWrapper(String fName , String lName)
        {
            this.fName = fName;
            this.lName = lName;
        }
    }
}
public class fecebookController
{

     String clientId='506982856097461';
     String redirect_uri='https://ap1.salesforce.com/apex/fecebookpage';
     String client_secret='e61b8778ffded0e1af0f4378f913838e';
     private String code;
   
    public fecebookController()
    {
         code = ApexPages.currentPage().getParameters().get('code');
         System.debug('---------------------------------------'+code);
    }

    public pageReference doAuthorization()
    {
    
    code= code+'#_=_'; 
    String body='client_id='+clientId+'&redirect_uri='+redirect_uri+'&client_secret='+client_secret+'&code='+code;

     
    String endpoint='https://graph.facebook.com/oauth/access_token'; 
 
    String header='';
    HttpRequest req = new HttpRequest();
    //endPoint = EncodingUtil.urlEncode(endPoint,'UTF-8');
    endpoint=endpoint+'?'+body;
    req.setEndpoint(endPoint);
    req.setMethod('GET');
    Http http = new Http();
    System.debug('=========== REQ BODY:'+endPoint);
    HTTPResponse res = http.send(req);
    System.debug('-----------------------------------------------------'+ res.getBody());

    return null;

    }
}
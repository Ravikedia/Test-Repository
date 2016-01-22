public with sharing class SalesforceTool
{
    final String endpoint = 'https://ap1.salesforce.com/services/data/v31.0/tooling/sobjects';

    // SomeValues to be store
    public String oid ;
    public String cid ;
    public String apmid ;
    public String carid ;

    public SalesforceTool()
    {
    }

    // used receive response by sending a http request
    private String getResponse(HttpRequest req)
    {
        try
        {
            Http
            httpreq = new Http();
            HttpResponse
            res = httpreq.send(req);
            String reqresponse = res.getBody();
            return
            reqresponse;
        }
        catch (Exception e){return
        'Error:' +e.getMessage();}
    }

    // create a http request with required endpoint and request method
    private HttpRequest  createHttpRequest(String endpoint, String method)
    {
        HttpRequest req = new
        HttpRequest();
        endpoint += '';
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(endpoint);
        req.setMethod(method);
        return req;
    }
    
    public void createApexClass()
    {
    // create a Http request with post method
    HttpRequest req = createHttpRequest(endpoint+'/ApexClass','POST');
    
    System.debug('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'+req);
    req.setBody( '{"Name":"NewApexClass3","Body":"public class NewApexClass3 {}"}');
    // send request and receive response
    String response = getResponse(req);
    
    System.debug('#############################'+response );
    // These two lines have no role in creating apex class. So they can be ignored for now.
    Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response);
    oid = (String)rmp.get('id');
    
  System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oid );
   }
    
    
    // [Status=No Content, StatusCode=204]
public void deleteApexClass()
{
    oid='01p90000005iuGz';
    HttpRequest req = createHttpRequest(endpoint+'/ApexClass/'+oid,'DELETE');
    String responseJson = getResponse(req); // Store the result to do something
}
}
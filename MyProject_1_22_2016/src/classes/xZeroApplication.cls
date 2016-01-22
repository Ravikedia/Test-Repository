public class xZeroApplication
{
    public xZeroApplication()
    {
    
    
    }
    
    
    public void ChekAuthentication()
    {
    
        Http h = new Http();
        String consumer_key='03TWOMPJAKMHXCWNIIUKGHYFIN62FB';
        String secret ='NXSBTSMZPFMSLQMGDXJHIQKX4TCZHC';
        Long tmp=(System.now().getTime()/1000);
        
        Blob isItCorrect = Crypto.generateMac('HMacSHA1', Blob.valueOf('https://api.xero.com/api.xro/2.0'), Blob.valueOf(consumer_key));
        String signature= EncodingUtil.urlEncode(EncodingUtil.base64Encode(isItCorrect), 'UTF-8');
    
        // Try to get access token
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.xero.com/oauth/RequestToken?oauth_consumer_key='+consumer_key+
             '&oauth_signature_method=HMAC-SHA1'+
               '&oauth_signature='+signature+
               '&oauth_timestamp='+tmp+ '&oauth_nonce='+tmp+'&oauth_version=1.0&scope=https%3A%2F%2Fapi.xero.com%2Fapi.xro%2F2.0');
        req.setMethod('GET');
        
           //Send the request, and return a response
        HttpResponse res = h.send(req);
        System.debug('##################'+res.getBody());
         
    }
}
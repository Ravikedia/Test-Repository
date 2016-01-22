global class GetClientDataWebService 
{
    webService static string retrieveClientData(String fName , String lName)
    {  
        List<ClientWrapper> clientWrap = new List<ClientWrapper>();
        String queryString = 'SELECT First_Name__c , Last_Name__c FROM Client__c WHERE First_Name__c Like \'%' + fName + '%\' AND Last_Name__c Like \'%' + lName + '%\' ';
        List<Client__c> clientList = Database.query(queryString);
        for( Client__c client : clientList)
        {
            clientWrap.add(new ClientWrapper(client.First_Name__c,client.Last_Name__c));
        } 
        return JSON.serializePretty(clientWrap);
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
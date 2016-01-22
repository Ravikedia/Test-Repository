public class Mycontroller {
public string FilterId{get;set;}
public list<Sobject> results;

 public PageReference renderdiffview() {

   String res =' [select id,name from '+ FilterId+' limit 1000]';
   results=database.query(res);
     return null;
    }

    public List<Sobject> getresults() {       
     return results;
    }

    List<Schema.SObjectType> gd =Schema.getGlobalDescribe().values();
    List<selectoption> sop=new List<selectoption>();
   
  
        
   
     
    
    public List<selectoption> getMyname()
    {
   
    for(Schema.SobjectType obj: gd)
    {
    
         sop.add(new selectoption(obj.getDescribe().getName(),obj.getDescribe().getName()));
         
    }
    return sop;
  
}













}
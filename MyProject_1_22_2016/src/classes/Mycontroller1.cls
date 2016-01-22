public class Mycontroller1 
{
    //String variable for Select Api name from picklist
    public String FilterId{get;set;}
   //List of id and name returned by getresult() method
    public List<Sobject> results{set;get;}
    //method that return the visualforce page refrence
    public PageReference view()
    {
          try
          {
             //Dynamic query for Select id and name field from selected object in piklist
             String res ='select id,name from '+ FilterId+' limit 1000';
             results = database.query(res);
          }
          catch(Exception e)
          {
          System.debug('The Following exception has occured: '+ e.getMessage());
          }
             
     return null;
    }
    //Return the List of id and name from selected object in piklist
    /*public List<Sobject> getresults()
    {       
        return results;
    }*/
    //Getting the values from Schema class's getGlobalDescribe method
    List<Schema.SObjectType> gd =Schema.getGlobalDescribe().values();
   // List of select option that specifies the value of selectList 
    List<selectoption> sop=new List<selectoption>();
    // Method that are used for retriving the name and label field of object
    public List<selectoption> getMyname()
    {
        sop.add(new selectoption('---None---','---None---'));
        for(Schema.SobjectType obj: gd)
        {
            //Adding the label of object in picklist
            sop.add(new selectoption(obj.getDescribe().getName(),obj.getDescribe().getLABEL()));
        }
            return sop;
    }
}
public class DynamicTable 
{
       private integer counter=0;  
       private integer list_size=5; 
       public integer total_size; 
       
    

    public PageReference Beginning()
    {
        counter = 0;
        return null;
    }
    public PageReference previous()
    {
        counter -= list_size;
        return null;
    }

    public PageReference next()
    {   counter += list_size;
        return null;
    }


   
     public PageReference End()
     {  
        counter = total_size - math.mod(total_size, list_size);
        return null;
    }


  

    //String variable for Select Api name from picklist
    public String FilterId{get;set;}
   // public String search{get;set;}
    
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
             total_size= results.size();
          }
          catch(Exception e)
          {
          System.debug('The Following exception has occured: '+ e.getMessage());
          }
             
     return null;
    }
    
    
       public Boolean getDisablePrevious()
        { 
     
        if (counter>0) return false; else return true;
       }
 
   public Boolean getDisableNext() 
   { 
      if (counter + list_size < total_size) return false; else return true;
   }
    
      public PageReference search() {
        return null;
    }
    public Integer getTotal_size() {
      return total_size;
   }
 
   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
 
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
   
    //Return the List of id and name from selected object in piklist
    /*public List<Sobject> getresults()
    {       
        return results;
    }*/
    //Getting the values from Schema class's getGlobalDescribe method
    map<String,Schema.SObjectType> gd =Schema.getGlobalDescribe();
    
   // List of select option that specifies the value of selectList 
    List<selectoption> sop=new List<selectoption>();
   
    // Method that are used for retriving the name and label field of object
    public List<selectoption> getMyname()
    {
        sop.add(new selectoption('---None---', '---None---'));
        for(String obj: gd.keyset())
        {
                
                Schema.DescribeSObjectResult r = gd.get(obj).getDescribe();
                if(r.iscustom())
                {
                sop.add(new selectoption(r.getName(),r.getLabel()));
                }
                //Schema.SObjectType s = gd.get(obj);
                 
               // Schema.DescribeSObjectResult res = s.getDescribe() ;
                 
               // Map<String,Schema.SObjectField> fields = res.fields.getMap() ;
               
               // http://wikisf.blogspot.in/2012/08/salesforce-interview-questions-1.html
             //  for(Schema.SObjectField fieldAPI : fields.values())  
               //{ 
                 // if(fieldAPI.getDescribe().getName()=='name' && fieldAPI.getDescribe().getName()=='Name')
                 // {
                      //Adding the label of object in picklist
                   
                  //}
               
            // }
        }
         return sop;
    }
}
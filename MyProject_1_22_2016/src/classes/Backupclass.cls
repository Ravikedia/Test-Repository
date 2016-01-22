public class Backupclass
{

   private integer counter=0;  
   private integer list_size=5; 
   public integer total_size; 
   
   
    public PageReference End()
    {
         counter = total_size - math.mod(total_size, list_size);
         //return null;
         getSelectedproducts();
         return  view();
    }

   
  // public String disableNext { get; set; }
    public Boolean getDisableNext()
     {
     //this will disable the next and end buttons
        // total_size=11;
     if (counter + list_size < total_size) return false; else return true;
    }
    
    
   // public String disablePrevious { get; set; }
    public Boolean getDisablePrevious() 
    { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
    }

    public PageReference Next()
    {
         counter=counter+list_size;
         getSelectedproducts();
         view();
      
            return null;
      
    }


    public PageReference Previous()
    {
        counter=counter-list_size;
        //return null;
        getSelectedproducts();
        return  view();
    }



    public PageReference Beginning()
    {
        counter=0;
        getSelectedproducts();
       // return null;
        return  view();
    }


    
    //String variable for Select Api name from picklist
    public String FilterId{get;set;}
    
    
   //List of id and name returned by getresult() method
    public List<Sobject> results{set;get;}
    private List<sobject> total;
    public String searchvalue{set; get;}
    public List<Wrapperclass> recordList{set;get;}
    String firstobject=null;
    public List<sobject> selectedrecords;
    
   
   private boolean test=false;
    
   
    
 
    public PageReference view()
    {
             if(firstobject!=FilterId)
             {
             counter=0;
             }
             firstobject=FilterId;
             
         try
          {
                 if(recordList== null|| searchvalue!=null)
                 {
                 recordList= new List<Wrapperclass>();
                 String res='select id,name from '+ FilterId + '  where  name like \'%'+searchvalue+'%\' limit 5 offset '+ counter ;
                //results = database.query(res);
                
                     for(Sobject c:database.query(res)) 
                     {
                         recordList.add(new Wrapperclass(c));
                     }
                  }
                     String str ='select id,name from '+ FilterId+' where name like \'%'+searchvalue+'%\' limit 1000';
                     total=database.query(str); 
                     total_size=total.size();
                      getSelectedproducts();
                 
                  }
                  catch(Exception e)
                  {
                  System.debug('The Following exception has occured: '+ e.getMessage());
                  }
                     
             return null;
     }
    
    
    public Integer getTotal_size()
    {
      return total_size;
    }
    public Integer getPageNumber()
    {
      return counter/list_size + 1;
    }
   
    public PageReference processSelected()
    {
        test=true;
        selectedrecords = new List<sobject>();
      
         for(Wrapperclass cCon: recordList)
         {
     
             if(cCon.selected == true)
             {
                 selectedrecords.add(cCon.con);
               
        
                
             }
         }
         
         System.debug('These are the selected Records......');

         for(sobject con: selectedrecords)
         {
 
            system.debug(con);

         }
         
        
         // getSelectedproducts();
        //contactList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
         PageReference pageRef =Page.viewpage;
         pageRef.setRedirect(false);
         return pageref;
     }
      public set<Sobject> SelectedprodList=new set<Sobject>(); 
       public set<Sobject> getSelectedproducts()
        {
      //  selectedprodList = new list<Sobject>();      
        for(Wrapperclass cCon:recordList)
        {            
            if(cCon.selected==true)  
            {                        
             
                selectedprodList.add(cCon.con);
               
            }                           
        }        
         return selectedprodList;           
         }        
     

     map<String,Schema.SObjectType> gd =Schema.getGlobalDescribe();
     List<selectoption> sop=new List<selectoption>();
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
               
         }
         return sop;
     }
       
       
        public class Wrapperclass
        {

        public sobject con {get; set;}

        public Boolean selected {get; set;}

 

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false

            public Wrapperclass(sobject c) 
            {

                con = c;

                selected = false;
            }

        }


}
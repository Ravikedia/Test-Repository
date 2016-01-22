public class DynamicTab 
{

    private integer counter=0;  
    private integer list_size=5; 
    public integer total_size; 
      
    //String variable for Select Api name from picklist
    public String FilterId{get;set;}
    
    //List of id and name returned by getresult() method
    public List<Sobject> results{set;get;}
    
    private List<sobject> total;
    //Search value entered by visualforce page
    public String searchvalue{set; get;}
   
    //wrapperclass list for store records
    public List<Wrapperclass> recordList{set;get;}
   // public List<Wrapperclass> finalrec{set;get;}
    
    String firstobject=null;
    //list for store selected records
    public List<sobject> selectedrecords;
    
    
    private boolean test=false;
   
   // this method call when we click >>(end) option in UI
    public PageReference End()
    {
         counter = total_size - math.mod(total_size, list_size);
         //return null;
         getSelectedproducts();
         return  view();
    }

   
   //for disable Next Buttons
    public Boolean getDisableNext()
    {
     //this will disable the next and end buttons
     if (counter + list_size < total_size) return false; else return true;
    }
    
    //for disable Previous Button
    public Boolean getDisablePrevious() 
    { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
    }
    //this method is called when we click Next Buttons 
    public PageReference Next()
    {
         //counter size increase by list size
         counter=counter+list_size;
         getSelectedproducts();
         processSelected();
         view();
      
            return null;
     }

    //this method is call when we click previous Button(<) from user interface
    public PageReference Previous()
    {
        //counter size decrease by list size
        counter=counter-list_size;
        //return null;
        getSelectedproducts();
        processSelected();
        return  view();
    }


    // when we click (<<) from us that time this method call
    public PageReference Beginning()
    {
        counter=0;
        getSelectedproducts();
       // return null;
        return  view();
    }

    public DynamicTab()
    {
        
      system.debug(':::::::::::::::::test::::::::::::::'+test);
    }
    
     //this function for fire query and getting records from database
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
                  // recordList object for storing our records
                  recordList= new List<Wrapperclass>();
                  //here we store query in String that find id and name from selected object from picklist
                  String res='select id,name from '+ FilterId + '  where  name like \'%'+searchvalue+'%\' limit 5 offset '+ counter ;
                  //results = database.query(res);
                  for(Sobject c:database.query(res)) 
                  {
                      //passing records to the wrapper class
                      
                       recordList.add(new Wrapperclass(c));
                   
                  }
              }
                  //query for finding number of records in selected object
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
    
    //this function return total size of records
    public Integer getTotal_size()
    {
      return total_size;
    }
    //using this function we can find page Number in which we are working
    public Integer getPageNumber()
    {
      return counter/list_size + 1;
    }
   // we find number of records selected and store in list 
    public PageReference processSelected()
    {
        test=true;
        selectedrecords = new List<sobject>();
      
         for(Wrapperclass cCon: recordList) 
         {
     
             if(cCon.selected == true)
             {
                 selectedrecords.add(cCon.con);
          
                 System.debug(':::::::::::::::'+  cCon.selected);
               
             }
         }
         
             System.debug('These are the selected Records......');

         for(sobject con: selectedrecords)
         {
 
            system.debug(con);

         }
         
         PageReference pageRef =Page.viewpage;
         pageRef.setRedirect(false);
         return pageref;
     }
        
        
        
     
   /* public void getFinalRecord()
    {
        for(Wrapperclass rec:recordList) 
        {
            System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::' + rec);
            finalrec.add(rec);
        }
    
    }*/
    
    
     
    public set<Sobject> SelectedprodList=new set<Sobject>(); 
    public set<Sobject> getSelectedproducts()
    {
        //selectedprodList = new list<Sobject>();      
        for(Wrapperclass cCon:recordList)
        {            
            if(cCon.selected==true)  
            {                        
              //store records in selectedprodlist
               selectedprodList.add(cCon.con);
               cCon.selected=true;
               
            }                           
        }        
         return selectedprodList;           
     }   
    /* public   List<Wrapperclass> selandDselrecords()
     
     { 
     return recordList;   
     }*/
     //Schema.getGlobalDescribe() function return key and value at particular key
     map<String,Schema.SObjectType> gd =Schema.getGlobalDescribe();
     //Selectionoption is a class that store label and value 
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
                selected =false;
            }

    }


}
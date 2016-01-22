public class contactrecord
{
    //Get the selected records ids 
    private string contactID = '';
    //Store the list of records after exicuting query
    private LIst<contact> listrecord{get; set;}
    //Store records with checkbox selected or deselected value
    public  List<ContactWrapper> cWrapper{get; set;}
    //store selected records
    private List<contact> selectedrecords;
   
    //constructor for class
    public contactrecord()
    {
       // Wrapper class object
        cWrapper=new List<ContactWrapper>();
        listrecord=new List<contact>();
        //Getting ids from the list of selected records
        try
        {
        contactID = System.currentPageReference().getParameters().get('fcf');
        
       
        List<Id> contactids=contactID.split(',');
        //Retriving some fields from ids
        listrecord= [Select ID, Name, Accountid,title,phone,email,ownerid,Date__c,Datetime__c From Contact Where ID IN :contactids];
        System.debug('----listrecord------'+listrecord);
        }
         catch(Exception e)
        {
        System.debug(e);
        }
            for(Contact c:listrecord)
            {
                // Add records with wrapper class 
                cWrapper.add(new ContactWrapper(c));
               
            }
         
      }
     // This method call when we save our records
     public PageReference saverecord()
     {
       
         selectedrecords = new List<contact>();
    
         System.debug('------------------cwrapper------------------------'+cWrapper);
      
         for(ContactWrapper cCon: cWrapper) 
         {
     
             if(cCon.selected == true)
             {
                  //Add selected records in selected record list
                  selectedrecords.add(cCon.tContact);
                 
               
             }
                 System.debug(':::::::::::::::'+  selectedrecords);
                 //update selected records
                 update selectedrecords;
         }
     
              return returnToOrigination();
     }
      //After updating records return back on Origination
      private  pageReference returnToOrigination()
      {
          PageReference page = new PageReference('/003?fcf=00B900000071dT3');
          page.setRedirect(true);
          return page;
          
          return null;
      }
     Public PageReference CancelRecord()
     {
          return returnToOrigination();
     }
    //Wrapper class for contact records
    public class ContactWrapper
    {
        public Contact tContact{get;set;}
        //whether the record is selected
        public Boolean selected{get;set;}
        // public integer rowNo {get;set;}
        //Constructor for wrapper class
        public ContactWrapper(Contact c)
        {
            this.tContact=c;
            this.selected=true;
              
        }
    }
}
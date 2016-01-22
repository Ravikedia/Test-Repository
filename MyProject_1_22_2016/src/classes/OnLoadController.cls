public class OnLoadController {

    public String Page {get; set;}
    public String OpenPageURL {get; set;}
    public Dynamicurl__c total{get; set;}
    public string step='1';
    public void OnLoadController()
    {
        Page = '' ;
        OpenPageURL = '' ;
       // total='';
    }

    public PageReference redirect()
    {
        if(Page == 'google')
        {
          total=new Dynamicurl__c();  
          
           // OpenPageURL =[select url__c from Dynamicurl__c limit 1] ; 
              String str ='select url__c from Dynamicurl__c where Stepnumber__c like \'%'+step+'%\' limit 1';
              total=database.query(str); 
              system.debug('total value issssssssssssssssss'+total);
            
        }
        if(Page == 'mpay')
        {
            OpenPageURL = 'https://www.yahoo.com/' ;
        }
        return null;
    }
  /* public List<Dynamicurl__c> getrecord()
    {
           String str ='select url__c from Dynamicurl__c where Stepnumber__c like \'%'+step+'%\' limit 1';
          //  \'%'+searchvalue+'%\'
          total=database.query(str); 
         
        // String OpenPageURL =total.url__c;
           return total;
        }*/
    
    

}
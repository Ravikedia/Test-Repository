public class wizarduicontroller
{

    //user for to retrive user records for to maintain step
    public User username { get; set; }
    
    // private List<Registration__c> register;
    // public String userlastname { get; set; }
    public String password{get; set;}
    // public  Registration__c registration{get;set;}
   // public  Contact c   { get;set; }
    public  Recordmaintain__c rmaintain{get; set;}
    public User user{get; set;}
    //page store step number
    public String Page {get; set;}
    public String OpenPageURL {get; set;}
    //total store url value return select by database
    public Dynamicurl__c total{get; set;}
    public string stepss='1';
    // store name ,id of user
    public User nameuser{get; set;}
    integer step;
    Integer flag=0;
    public List<Dynamicurl__c> stepvalue{get; set;}
 
    public PageReference Storedparamvalue()
    {
        System.debug('yes i am here');
        return null;
    }

     public PageReference redirect()
     {
       
          total=new Dynamicurl__c();  
          
           // OpenPageURL =[select url__c from Dynamicurl__c limit 1] ; 
           //query that retrive page url from custom object
              String str ='select url__c from Dynamicurl__c where Stepnumber__c like \'%'+Page +'%\' limit 1';
              total=database.query(str); 
              system.debug('total value issssssssssssssssss'+total);
            
     
       /* if(Page == 'mpay')
        {
            OpenPageURL = 'https://www.yahoo.com/' ;
        }*/
        return null;
    }
    
    public wizarduicontroller()
    {
       
        //Page = 'step1' ;
        OpenPageURL = '' ;
       // String str ='select url__c from Dynamicurl__c where Stepnumber__c like \'%'+Page +'%\' limit 1';
        //total=database.query(str); 
        system.debug('total value issssssssssssssssss'+total);
        step=1;
        //registration=new Registration__c ();
       // c = new Contact();
        rmaintain=new Recordmaintain__c();
       // System.debug('--------------'+rmaintain);
        user=new User();
        
        System.debug(username);
        username=[select id, name, username from User  LIMIT 1];
       // nameuser= [select id, name, username from User  LIMIT 2];
      //  System.debug('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'+    nameuser);
        //registration=[select id, name__c from Registration__c ] ;
     
    }
   
    public boolean getCheck() {
        boolean b=false;
        
        
        if (2<=step)
            return true;
        else
            return false;
    }
   // method return true value if one is less then or equal to step number
    public boolean getcheckstep1()
    {
       stepvalue=new List<Dynamicurl__c>();
       for(integer i=1;i<=step; i++)
       {
          String dynamicvalue='select Stepnumber__c from Dynamicurl__c where Name like \'%'+i+'%\' limit 1';
          stepvalue.add(database.query(dynamicvalue)); 
          System.debug('--------------------------------------------------------------------------------------'+stepvalue);
          
        }
    
        if (1<=step)
            return true;
        else
            return false;
    }
   
    // method return true value if one is less then or equal to step number
    
     public boolean getcheckstep2()
     {
        if (1<=step)
            return true;
        else
            return false;
     }
    
     public boolean getcheckstep3()
     {
         if (3<=step)
             return true;
         else
             return false; 
     }
    
     public boolean getcheckstep4()
     {
         if (4<=step)
             return true;
         else
             return false; 
     }
     public boolean getcheckstep5()
     {
      
     if (5<=step)
         return true;
     else
         return false; 
           
    }
      public boolean getcheckstep6()
     {
      
     if (6<=step)
         return true;
     else
         return false; 
           
    }
    
    
    public PageReference Step4()
    {
       
        step=4;
        getcheckstep4();
        return null;
    }
    public PageReference Step3()
    {
         step=3;
         getcheckstep3();
         return null;
    }


    public PageReference Step2()
    {
      
          step=2;
          getcheck();
          return null;
    }


    public PageReference Step1()
    {
          step=1;
          getcheckstep1();
          return null;
    }
    
    public PageReference Step5()
    {
        step=5;
        getcheckstep5();
        return null;
    }
    
    public PageReference  logoutpage()
    {
     PageReference pageRef =  new PageReference('/apex/wizarduilogin');
       pageRef.setRedirect(false);
       return pageRef;
    
    
    }
    //this method used for to update record inrecord maintain custom object
    public void Updatevalue()
    
    {
    String stepupdate=String.valueOf(step);  
    rmaintain.Step__c=stepupdate;
    update rmaintain;
    
    }
    // this method maintain each step
   public void maintainsteps()
   {
       System.debug('uuuuuuuuuuuuuuuuuuuuuuuuuuuuu'+rmaintain.User__c);
       //String value=rmaintain.User__c;
      // Integer val=Integer.parseInt(value);
      // System.debug('-----------'+value);
       
       string fid = rmaintain.User__c;
       String dynamic='select  name, username from User where id=:fid';
       System.debug('query  '   +dynamic);
       nameuser=database.query(dynamic); 
       System.debug('----------------------------------rmaintain-----------------------------'+nameuser);
           try
           {  
            String stepstr=String.valueOf(step);  
            System.debug('--------------ststtstts----------------------------------'+stepstr);
            Recordmaintain__c recordmaintain=new Recordmaintain__c(User__c=nameuser.id, Step__c=stepstr, username__c=nameuser.name);
            insert recordmaintain; 
            System.debug('----------------------------------username-------------'+nameuser.name);
       
           }
           catch(Exception e)
           {
           
           System.debug(e);
           }
       
      
     
       String userrecord='select User__c ,Step__c,username__c   from Recordmaintain__c where username__c   like \'%'+ nameuser.name +'%\'  limit 1';
       rmaintain=database.query(userrecord); 
       
       System.debug('----------------------------------------------------'+rmaintain);
       System.debug('----------------------------------------------------'+rmaintain.username__c);
       System.debug('----------------------------------------------------'+rmaintain.Step__c);
      
      
      
       //if user is old then user in pervious step in which user left this procedure
       if( Integer.valueOf(rmaintain.Step__c)>0)
       { 
        step = Integer.valueOf(rmaintain.Step__c);    
       }
       
    }
   
   
    // when user login that time user setredirect on stepcomplete page
   public PageReference loginuser()
   {
   
       maintainsteps();
      // String pg = Page.wizardbestui ;
       PageReference pageRef =  new PageReference('/apex/wizarduipage');
       pageRef.setRedirect(false);
       return pageRef;
         
        
   
   }
    
     public PageReference Recordmaintains()
     {
         System.debug('---------------------'+username);
         System.debug('---------------------'+password);
         step++;
      
         
        if(step>6)
         {
            /*List<Registration__c> register=new List<Registration__c>();
            Registration__c reg=new Registration__c(Name__c=username, password__c=password);
            insert reg; */
             step=6;
         }
        
             Updatevalue();
        
            String str ='select url__c from Dynamicurl__c where Stepnumber__c like \'%'+step+'%\' limit 1';
            total=database.query(str); 
            system.debug('total value issssssssssssssssss'+total);
        
        
          return null;
    }
}
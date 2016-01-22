public with sharing class MyCustomController {
    public  Contact c   { get;set; }
  public  Registration__c registration{get;set;}

    public MyCustomController() { 
        c = new Contact(); 
        
        registration=new Registration__c ();
    }
}
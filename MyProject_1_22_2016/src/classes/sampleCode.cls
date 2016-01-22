public with sharing class sampleCode {

public List<wrapper> wrapperList{get; set;}
public List<Contact> contactsInformation { get; set; }
public Id selectedCountOfContact { get; set; }


public sampleCode(){
         wrapperList=new List<Wrapper>();
         for(Account a:[select id,Name,(select id,name from contacts),(select id from opportunities)  from Account limit 5])
         {
           Wrapper w1=new Wrapper();
           w1.Name=a.Name;
           w1.Con=a.contacts.size();
              
           w1.Opp=a.opportunities.size();
           w1.recordid =a.id;
           wrapperList.add(w1);
         }       
}

class Wrapper{
    public String Name{get; set;}
    public Integer Con{get; set;}
    public Integer Opp{get; set;}   
    public Id recordid{get; set;}
 }
 
public List<Account> getMyAccounts() {
return [SELECT Id, Name,Industry, AccountNumber FROM Account ORDER BY
LastModifiedDate DESC LIMIT 10];
}

public void accountClicked() {
contactsInformation = [SELECT FirstName, LastName FROM Contact
WHERE AccountID = :selectedCountOfContact];
  }
}
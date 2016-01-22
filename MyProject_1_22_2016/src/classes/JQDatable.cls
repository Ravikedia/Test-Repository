public with sharing class JQDatable {

  //List of Account 
  public List<Account> getAccounts() {
     return [SELECT Id, Name, Phone, AccountNumber, Type, Owner.Name FROM Account];
   }
}
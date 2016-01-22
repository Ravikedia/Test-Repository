@isTest 
public class TestRestrictContactByName{
   
   
    static testMethod void insertNewUser() 
    {
       try
       {
       Account acc = new Account(Name = 'test');
       insert acc;
       Contact con = new Contact();
       con.LastName = 'INVALIDNAME';
       con.AccountId = acc.id;
       insert con;
       }
       catch(Exception e)
       {
       }
    }
    
  
}
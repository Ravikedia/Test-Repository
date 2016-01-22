@isTest 
public class TestVerifyDate{
   
   
    static testMethod void insertNewUser() 
    {
        VerifyDate.CheckDates(date.today() + 1, date.today());
    }
    
    static testMethod void insertNewUser1() 
    {
        VerifyDate.CheckDates(date.today(), date.today()+1);
    }
}
public class AutoCompleteController
{
   // Search value store in string
    public String searchvalue{get;set;}
    //List that store account records
    public List<Sobject> RecordList{get;set;}
    
    //Return account object list
    public list<account> getAccountList()
    {
         return [select id,name,Type,Phone from account limit 25];
    }
    public  AutoCompleteController()
    {
        System.debug(':::::::::cons::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::');
    }
    
    Public PageReference Records()
    {
       //Dynamic query for account records using search value
        String str='select id,Name, Phone, Type from account where name like \'%'+searchvalue+'%\' limit 25';
        RecordList=database.query(str);
        //return RecordList;
        return null;
    }
    
}
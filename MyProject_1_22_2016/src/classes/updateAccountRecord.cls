public class updateAccountRecord 
{
    public updateAccountRecord ()
    {
    
    }
    public void updateAccount()
    {
     List<Account> acc = [select id, name from Account where Name = 'testing1' limit 10000]; 
     List<Account> updateList = new List<Account>();
    //  List<Account> updateList1 = new List<Account>();
     for(Account a : acc)
     {
         a.Name = 'testing2';
         updateList.add(a);
        // updateList1 .add(
         
     }
        System.debug('#################################'+updateList.size());
        System.debug('#################################'+acc .size());
        update updateList;
        update acc ;
    }
    
}
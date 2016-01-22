public class RetriveAccountRecord
{
    public List<Account> data{get; set;}
    public RetriveAccountRecord()
    {
        data =new  List<Account>();
        data=[select id, name from Account];
    }
}
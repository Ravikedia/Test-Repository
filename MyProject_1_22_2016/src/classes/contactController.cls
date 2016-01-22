public class contactController
{
   
    public Contact cont{get; set;}
    public contactController()
    {
        cont=new Contact();
    
    }
    public void retriveDetail()
    {
        System.debug('*******************'+cont.AccountId);
        List<Account> accinformation=[select id, (select id, name from contacts), name from Account where id = :cont.AccountId];
        System.debug('************'+accinformation[0].contacts);
    
    }
    
}
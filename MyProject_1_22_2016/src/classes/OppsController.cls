public class OppsController
{   
    @RemoteAction
    public static  List<Opportunity> getOpportunities()
    {
        List<Opportunity> opp=[SELECT name, amount FROM Opportunity];
        return opp;
    }
}
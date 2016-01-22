public with sharing class Pagination_min {
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public ApexPages.StandardSetController setCon {
        get{
                system.debug('#################I Am In getter#########');
                size = 10;
                string queryString = 'Select Name, Type, BillingCity, BillingState, BillingCountry from Account order by Name limit 100';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                System.debug('###############'+setCon.getResultSize());
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
       
            return setCon;
        }set{ system.debug('#################I Am In SSSSSSSetter#########'+setCon.getPageNumber());}
    }
     
    Public List<Account> getAccounts(){
        List<Account> accList = new List<Account>();
        for(Account a : (List<Account>)setCon.getRecords())
            accList.add(a);
        return accList;
    }
     
    public pageReference refresh() {
        setCon = null;
        getAccounts();
        setCon.setPageNumber(1);
        return null;
    }
}
public class PaginationController
{
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 20;
    public List<Wrapperclass> recordList{set;get;}
    public Set<id> accountId;
    public Integer pageNumber{get;set;}
    public Integer totalPage{get;set;}
    public Integer totalRecords{get;set;}
    public List<Wrapperclass> listOfSearchData{get;set;}
   // public Set<Id> setOfAccountId;
    public Id accId; 
    public Id accfirstId;
    public String buttonValue;
    public PaginationController()
    {
        //setOfAccountId = new Set<Id>();
        listOfSearchData = new List<Wrapperclass>();
        recordList= new List<Wrapperclass>();
        accountId = new Set<Id>();
        totalRecs = [select count() from account];
        totalRecords = totalRecs ;
        Integer modforpageNumber = math.mod(totalRecs,LimitSize);
        if(modforpageNumber == 0 )
            totalPage = totalRecs / LimitSize ;
        else
            totalPage = totalRecs / LimitSize + 1;
        
        
        pageNumber = 1;
        buttonValue = 'next';
        recordListData();
        
    }
    public void recordListData()
    {
        
        
       
        
        recordList= new List<Wrapperclass>();
        List<Wrapperclass> recordList1 = new List<Wrapperclass>();
        String query = '';
        if(buttonValue == 'next')
            query = query +'SELECT id, Name, website, AnnualRevenue, description, Type FROM account where Id > :accId order by Id LIMIT :LimitSize';
        if(buttonValue == 'previous')
           query = 'SELECT id, Name, website, AnnualRevenue, description, Type FROM account where Id < :accfirstId   order by Id desc LIMIT :LimitSize'; 
        if(buttonValue == 'first')
           query = 'SELECT id, Name, website, AnnualRevenue, description, Type FROM account where Id < :accfirstId   order by Id LIMIT :LimitSize'; 
         if(buttonValue == 'last')
         {
             Integer lastpagesize = math.mod(totalRecs,LimitSize);
             query = 'SELECT id, Name, website, AnnualRevenue, description, Type FROM account order by Id desc LIMIT :lastpagesize';
         } 

            
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+query );  
        List<account> allAcc = Database.Query(query);
        List<Account> acc = new List<Account>();
        if(buttonValue == 'previous' || buttonValue  == 'last')
        {
            for(Integer i = allAcc.size()-1; i >= 0; i--)
            {
                acc.add(allAcc[i]);
            }
        }
        else
        {
            acc  = allAcc ;
        }
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+acc );
        accId  = null; 
        accId = acc[acc.size()-1].id;
        accfirstId = acc[0].id;
        
        //System.debug('@@@@@@@@@@@@'+setOfAccountId);
        
        for(Account accRec : acc) 
        {
            recordList1.add(new Wrapperclass(accRec)); 
                  
        }
        for(Wrapperclass wrapper : recordList1)
        { 
            if(accountId.contains(wrapper.con.id))
            {
                wrapper.selected = true;
                recordList.add(wrapper);
            }
            else
            {
                 recordList.add(wrapper);
            } 
        }  
        System.debug('#################'+ recordList);
        listOfSearchData  = recordList;
    }
    
    private void stateMaintain()
    {
        for(Wrapperclass wrapper : recordList)
        {
            if(wrapper.selected)
            {
                accountId.add(wrapper.con.id);
            }
            if(wrapper.selected == false)
            {
                accountId.remove(wrapper.con.id);
            }
        }  
    }
    
    public void FirstPage()
    {
        buttonValue = 'first';
        OffsetSize = 0;
        pageNumber = 1;
        stateMaintain();
        recordListData();
        
    }
    public void previous()
    {
        buttonValue = 'previous';
        pageNumber --;
        OffsetSize = OffsetSize - (LimitSize);
        stateMaintain();
        recordListData();
        
    }
    public void next()
    {
        buttonValue = 'next';
        pageNumber ++;
        OffsetSize = OffsetSize + LimitSize;
        stateMaintain();
        recordListData();
        
        
    }
    public void LastPage()
    {
        
        buttonValue = 'last'; 
        Integer modforPage = math.mod(totalRecs,LimitSize);
        if(modforPage == 0 )
        {
            OffsetSize = totalrecs - LimitSize;
            pageNumber  = totalRecs / LimitSize;
        }
        else
        {
             OffsetSize = totalrecs - modforPage;
             pageNumber  = totalRecs / LimitSize + 1;
        }
        stateMaintain();
        recordListData();
        
    }
    public boolean getprev()
    {
        if(OffsetSize == 0)
        return true;
        else
        return false;
    }
    public boolean getnxt()
    {
        if((OffsetSize + LimitSize) >= totalRecs)
        return true;
        else
        return false;
    }
    
    public class Wrapperclass
    {
        public Account con {get; set;}
        public Boolean selected {get; set;}
        public Wrapperclass(Account c) 
        {
            con = c;
            selected =false;
        }
    }
}
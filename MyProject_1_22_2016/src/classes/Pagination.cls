public class Pagination
{
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 20;
    public List<Wrapperclass> recordList{set;get;}
    public Set<id> accountId;
    public Integer pageNumber{get;set;}
    public Integer totalPage{get;set;}
    public Integer totalRecords{get;set;}
   // public Set<Id> setOfAccountId;
    public Id accId; 
    public Pagination()
    {
        //setOfAccountId = new Set<Id>();
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
    }
    public List<Wrapperclass> getrecordListData()
    {
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+accId  );
        
        recordList= new List<Wrapperclass>();
        List<Wrapperclass> recordList1 = new List<Wrapperclass>();

        List<account> acc = Database.Query('SELECT id, Name, website, AnnualRevenue, description, Type FROM account where Id > :accId order by Id LIMIT :LimitSize');
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+acc );
        accId  = null; 
        accId = acc[acc.size()-1].id;
        
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
        return recordList;
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
        OffsetSize = 0;
        pageNumber = 1;
        stateMaintain();
    }
    public void previous()
    {
        pageNumber --;
        OffsetSize = OffsetSize - (LimitSize);
        stateMaintain();
    }
    public void next()
    {
        pageNumber ++;
        OffsetSize = OffsetSize + LimitSize;
        stateMaintain();
        
    }
    public void LastPage()
    {
        
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
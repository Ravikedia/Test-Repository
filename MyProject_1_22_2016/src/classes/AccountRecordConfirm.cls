public Class AccountRecordConfirm
{
    public List<Account> accrecord{get; set;}
    public String accid{get; set;}
    public String accountid;
    public String uName{get; set;}
    public String pNumber{get; set;}
    public AccountRecordConfirm()
    {
        accrecord = new List<Account>();
        accrecord = [ Select id, name,AccountNumber from Account ];   
    }
    
    public Void selectedAccountId()
    { 
        System.debug(  ApexPages.currentPage().getParameters().get('abc'));
        String accId = '0019000000sFgkX';
      //  PageReference pageRef =  new PageReference('/apex/Accountpdf');
          PageReference pageRef = Page.Accountpdf;
        Attachment att = new Attachment(name ='Test'+System.now()+'.pdf');
         
        Pagereference TestPDF = Page.Accountpdf;
        TestPDF.getParameters().put('id',accId);
        att.body = TestPDF.getContent();
        att.parentid = accId;
        insert att;
       // pageRef.setRedirect(false);
      // return pageRef;
      
    }
}
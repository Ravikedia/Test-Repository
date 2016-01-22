public class JSRemotingFileUploadController {
public static Blob filevalue{get; set;}
public Blob file{get; set;}
public List<String>  attachmentid{get; set;}
public static Integer i ;
public String stringvalue{get; set;}

	public JSRemotingFileUploadController(ApexPages.StandardController c)
	{
    	attachmentid = new List<String>();
    	i=0;
    }
   	public JSRemotingFileUploadController ()
   	{
   		attachmentid = new List<String>();
   		i=0;
   	}
   	public PageReference Downloadpdffile()
   	{
    	attachmentid = new List<String>();
   		List<Attachment> listOfAttachment =	[SELECT Id,Name,ContentType FROM Attachment where ParentId ='a049000000HRSkc' AND Name = 'muimages'];
   		for(Attachment attach: listOfAttachment)
   		{
   			attachmentid.add(attach.id);
   		}
   		PageReference secondPage = Page.SelectMultiplefile1;
        secondPage.setRedirect(false);
        return secondPage;
  	 }
  	 
  	 public void DeleteAttachment()
  	 {
  	 	
  	 }

  /*  @RemoteAction
    public static void  doUploadAttachment(String acctId, String attachmentBody, String attachmentName, String attachmentId)
    {
        System.debug('INSIDE:::::::::::::::::'+attachmentName);
        Integer num= Integer.valueof(attachmentName);
        if(num==0)
        {
        	System.debug('INSIDE:::::::::::::::::'+i);
        	List<Attachment> listOfAttachment =	[SELECT Id,Name,ContentType FROM Attachment where ParentId ='a049000000HRSkc' AND Name = 'muimages'];
  	 		delete listOfAttachment;	
        }
        
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@#####################'+attachmentBody);
        filevalue = blob.valueof(attachmentBody);
        Attachment attach = new Attachment();
        attach.contentType = 'image/jpg';
        attach.name = 'muimages';
        attach.parentId = 'a049000000HRSkc';
        attach.body = EncodingUtil.base64Decode(attachmentBody );
        insert  attach ;
         
    }
    */
    
    
    @RemoteAction
    public static Id  doUploadAttachment(String attachmentName, String attachmentBody, String attachmenttype)
    {
        
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@#####################'+attachmentName);
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@#####################'+attachmentBody);
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@#####################'+attachmenttype);
        //filevalue = blob.valueof(attachmentBody);
        
        Attachment attach = new Attachment();
        attach.contentType = attachmenttype;
        attach.name = attachmentName;
        attach.parentId = '0039000001Ll3xe';
        attach.body = EncodingUtil.base64Decode(attachmentBody );
        //attach.body  = Blob.valueOf(attachmentBody);
        insert  attach ;
        
        return attach.id;
         
    }
     
     
    @RemoteAction
    public static String doSubmitForm(String acctId, String description, String website, String phone) {
        if(acctId != null) {
            Account acct = getAccount(acctId);
            if(acct != null) {
                acct.Description = description;
                acct.Website = website;
                acct.Phone = phone;
                update acct;
                return 'Success';
            } else {
                return 'Account could not be found';
            }
        } else {
            return 'Account Id was null';
        }
    }
     
    private static Account getAccount(String acctId) {
        list<Account> accounts = [SELECT Id, Name
                                  FROM Account
                                  WHERE Id =: acctId];
        if(accounts.isEmpty()) {
            return null;
        } else {
            return accounts[0];
        }
    }
     
    private static Attachment getAttachment(String attId) {
        list<Attachment> attachments = [SELECT Id, Body
                                        FROM Attachment 
                                        WHERE Id =: attId];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
}
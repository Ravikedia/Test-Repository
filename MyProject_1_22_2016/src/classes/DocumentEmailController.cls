public with sharing class DocumentEmailController {

  public ID documentId {get;set;}
  public String email {get;set;}

  public List<SelectOption> documents {
    get {
      if (documents == null) {
        documents = new List<SelectOption>();
        documents.add(new SelectOption('01590000009hdPX','Cup of Coffee? - DOC'));
      }
      return documents;
    }
    set;
  }
  
  public  String blobToString(Blob input, String inCharset){
    String hex = EncodingUtil.convertToHex(input);
    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@HEX'+hex );
    System.assertEquals(0, hex.length() & 1);
    final Integer bytesCount = hex.length() >> 1;
    String[] bytes = new String[bytesCount];
    for(Integer i = 0; i < bytesCount; ++i)
    {
        bytes[i] =  hex.mid(i << 1, 2);
        system.debug('#############################Byte'+ EncodingUtil.urlEncode(bytes[i] , 'UTF-8'));
    }
        
        
    return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
}


  public PageReference sendDoc() {

    Document doc = [select id, name, body, contenttype, developername, type 
      from Document where id = :documentId];
 
    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+blobToString(doc.body, 'UTF-8'));
    
    /*string paramvalue = EncodingUtil.base64Encode(doc.body);
    
    Blob blobValue = EncodingUtil.convertFromHex(paramvalue);

        system.debug('#################blobValue '+blobValue );
 
    System.debug('################paramvalue '+paramvalue );
    //String data = blobToString(doc.body, 'UTF8' );


    Attachment docnew =  new Attachment();
    docnew.Name = 'New document.docx';
    //String data2 = EncodingUtil.urlEncode(data, 'UTF-8');
    
    Blob paramvalue1 = EncodingUtil.base64Decode(paramvalue );
    
    //System.debug('################paramvalue1111 '+data .toString() );

    
    docnew.body = paramvalue1 ;
    docnew.parentId = 'a049000000HRSkc';
    docnew.contenttype = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    insert docnew ;
    System.debug('!!!!!!!!!!!!!'+docnew .id);*/
    
    
 
    
   /* Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType(doc.contentType);
    attach.setFileName(doc.developerName+'.'+doc.type);
    attach.setInline(false);
    attach.Body = doc.Body;
    
    
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('Document Email Demo');
    mail.setHtmlBody('Here is the email you requested: '+doc.name);
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 

    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Document sent to '+email));*/

    return null;

  }

}
public Class GenerateCSV {
    public List<Contact> getContacts() {
          return [select Id,Title,FirstName,LastName from Contact limit 20];
    }
    
    public void sendEmailforPdf()
    {
       // Attachment att = new Attachment(name ='Test'+System.now()+'.CSV');
        Pagereference TestPDF = Page.GenerateCSVPage;
  
        User theUser = [select Name, Email from User where isActive = true limit 1];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
       
        mail.setTargetObjectId(theUser.id);
        mail.setSubject('Generated csv file');    // Set the subject
        mail.setPlainTextBody('Body of your message' );
        mail.setSaveAsActivity(false);
       
        efa.setFileName('attachment.csv');
        efa.setBody(Blob.valueof('"Title,temp","First Name","Last Name"\nSVP, Procurement,Rose,Gonzalez\nceo,Sean,Forbes\nVP, Facilities,Jack,Rogers\nSVP, Administration and Finance,Pat,Stumuller\nSVP, Operations,Andy,Young\ntitle,Tim,Barr\nchange,John,Bond\nSVP, Production,Stella,Pavlova\nchange,Lauren,Boyle\nravikedia,Babara,Levy\ntitle,Josh,Davis\nDean of Administration,Jane,Grey\nCEO,Arthur,Song\nVP, Finance,Ashley,James\nRegional General Manager,Tom,Ripley\ntitle,Liz,D\'Cruz\nVP, Technology,Edna,Frank\nCFO,Avi,Green\nchange,Siddartha,Nedaerk\nC,Jake,Llorrac\na,b,c,d'));
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
       
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}
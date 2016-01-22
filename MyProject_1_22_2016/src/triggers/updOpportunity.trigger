Trigger updOpportunity on opportunity (after update)
{

    /*for(opportunity o:trigger.new){
        if(o.ownerid!=trigger.oldmap.get(o.id).ownerid &&o.ownerid==adminid){
            oppIds.add(o.id);*/
       List<opportunity > listofopp =  trigger.new;
       System.debug('##################'+  listofopp ); 
            
         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        // Reference the attachment page and pass in the account ID 
        Integer numAtts=[SELECT count() FROM attachment WHERE parentid=: listofopp[0].id];
        system.debug('Number of Attachments Atts = '+ numAtts);
        
        List<Attachment> allAttachment = new List<Attachment>();
        allAttachment = [SELECT Id, Name, ContentType, Body FROM Attachment WHERE parentid =: listofopp[0].id];
        // Create the email attachment 
        //List<Messaging.Emailfileattachment> efa = new List<Messaging.Emailfileattachment>();
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        // try{ 
        if(numAtts > 0){
                for (Integer i = 0; i < numAtts; i++){
                    system.debug(allAttachment[i].Name);
                    efa.setFileName(allAttachment[i].Name);
                    efa.setBody(allAttachment[i].Body);
                    efa.setContentType(allAttachment[i].ContentType);
                }
        }
         // } catch (ListException  e){
            // |DEBUG|List index out of bounds: 2
         //         system.debug( e.getMessage() );
        // } 


      //  String[] toAddresses = addresses.split(':', 0);

        // Sets the paramaters of the email 
        
        User theUser = [select Name, Email from User where isActive=true limit 1][0];
       // User sender =[select Name from User where id = :ta.CreatedById LIMIT 1][0];

       
        email.setTargetObjectId(theUser.id);
        email.setSaveAsActivity(false);
        email.setSubject('HI' );
       // email.setToAddresses('ravikantkedia@gmail.com' );
        email.setPlainTextBody( 'message' );
        //email.setFileAttachments(new Messaging.EmailFileAttachment[] {List<efa>()});
        if(numAtts > 0){
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        }

        // Sends the email 
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
       // return null;
    }
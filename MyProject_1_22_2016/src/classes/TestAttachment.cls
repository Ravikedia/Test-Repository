public class TestAttachment
{
    public Attachment attach{get;set;}
    public blob blobdata{get;set;}
    public TestAttachment()
    {
        attach = new Attachment ();
        
        String strrId = '00P9000000jFRXN';
        attach  = [SELECT id, body from Attachment  WHERE Id = :strrId ];
        blobdata = attach.body;
        //System.debug('################'+String.valueof(blobdata) );
    }
}
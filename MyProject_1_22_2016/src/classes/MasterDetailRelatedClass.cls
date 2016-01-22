public class MasterDetailRelatedClass
{
    public String masterobj{get; set;}
    public String childobj{get; set;}
    
    public MasterDetailRelatedClass()
    {
    
    }
    
    public void Retriverecord()
    {
   
    System.debug('#################'+masterobj);
    System.debug('#################'+childobj);
    Schema.SObjectType thisObjType = Schema.getGlobalDescribe().get(masterobj);
    system.debug('::::::::::::childObject::::::::::::::'+thisObjType );
    List<Schema.ChildRelationship> ChildObjList = thisObjType.getDescribe().getChildRelationships();
    // system.debug('::::::::::::childObject::::::::::::::'+ChildObjList );
           
    for (Schema.ChildRelationship child : ChildObjList ) 
    { 
            
        //for(Schema.ChildRelationship cr : Order__c.SObjectType.getDescribe().getChildRelationships()){
        // System.debug('@@@@@@@@@@@@@@@@@@@@@@'+ child .getRelationshipName()); 
         if(childobj== child.getchildSObject().getDescribe().getName())
         {
             String rsname = child .getRelationshipName();
             if( (rsname == null) ||  (rsname ==''))
             {
                 System.debug('NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN');
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Info, 'Relationship does not exist between object'));
             }
             else
             {
             
                //List<Sobject > sobj =[select id, name, (select id, name from rsname ) from masterobj];
                String  queryString= 'select id,name, (select id,name from '+ rsname +') from ' + masterobj;
                Schema.SObjectType thisObjType1 = Schema.getGlobalDescribe().get(child.getchildSObject().getDescribe().getName());

                List<SObject> queryParentObject = Database.query(queryString);
                System.debug('########################'+queryParentObject); 
                
                
                for (SObject parentRecord : queryParentObject)
                { 

                    System.debug('PARENT RECORD FROM ENTRED PARENT OBJECT'+parentRecord );
                    // Prevent a null relationship from being accessed
                    List<SObject> childRecordsFromParent = parentRecord.getSObjects(child .getRelationshipName());
                    
                    if (childRecordsFromParent != null) {
                    for (SObject childRecord : childRecordsFromParent)
                    { 
                        System.debug('CHILD RECORD FROM PARENT OBJECT'+childRecord ); 
                    }
                }              
                }







             }
         }
             //Schema.SObjectType thisObjType1 = Schema.getGlobalDescribe().get(child.getchildSObject().getDescribe().getName());
             //system.debug('=================================='+child.getchildSObject().getDescribe().getName() );   
      }
            
            
    
    }
    
}
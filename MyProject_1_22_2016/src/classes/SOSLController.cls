public with sharing class SOSLController
{
    public List<Event> eventList{get;set;}
    public List<Task> taskList{get;set;}
    public String searchStr{get;set;}
    public SOSLController()
    {
        taskList= New List<Task>();
        eventList = new List<Event>();
    }
  
    public void soslDemo_method()
    {
        taskList= New List<Task>();
        eventList = new List<Event>();
        
        if(searchStr.length() > 1)
        {    
            String queryName = '%' + searchStr + '%';
            String query = 'select id,Subject,Status,Priority,ActivityDate,AccountId,CallDisposition,CallDurationInSeconds,CallObject,CallType,Description from Task where ';
            map<String, Schema.SObjectField> FieldMap = Schema.SObjectType.Task.fields.getMap();
            for (Schema.SObjectField f : FieldMap.values())
            {
                Schema.DescribeFieldResult DescField = f.getDescribe();
                if (DescField.getType() == Schema.DisplayType.String || DescField.getType() == Schema.DisplayType.combobox ||  DescField.getType() == Schema.DisplayType.PICKLIST || DescField.getType() == Schema.DisplayType.PHONE )
                {
                    query = query+ DescField.getName() + ' Like :queryName OR ';  
                }
            }
            
            query = query.substring(0, query.length()-3);
            try
            {
           		 taskList = Database.query(query);
            }
            catch(Exception e)
            {
            	apexPages.addmessage(new apexpages.message(apexpages.severity.Error, e.getMessage()));
            	return;
            }
            
            String query1= 'select id,Subject,OwnerId,ActivityDate,AccountId,ActivityDateTime,Description,DurationInMinutes,EndDateTime,Location,RecurrenceDayOfMonth,RecurrenceDayOfWeekMask,RecurrenceEndDateOnly from Event where ';
            map<String, Schema.SObjectField> FieldMap1 = Schema.SObjectType.Event.fields.getMap();
            for (Schema.SObjectField f : FieldMap1.values())
            {
                Schema.DescribeFieldResult DescField = f.getDescribe();
                if (DescField.getType() == Schema.DisplayType.String || DescField.getType() == Schema.DisplayType.combobox ||  DescField.getType() == Schema.DisplayType.PICKLIST || DescField.getType() == Schema.DisplayType.PHONE )
                {
                    query1 = query1+ DescField.getName() + ' Like :queryName OR ';  
                }
            }
            query1 = query1.substring(0, query1.length()-3);
            try
            {
            	eventList  = Database.query(query1);
            }
            catch(Exception e)
            {
            	apexPages.addmessage(new apexpages.message(apexpages.severity.Error, e.getMessage()));
            	return;
            }
            
            if(taskList.size() == 0 && eventList.size() == 0)
            {
                apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Sorry, no results returned with matching string..'));
                return;
            }
        }
        else
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Please enter at least two characters..'));
            return;
        }
  }
 
}
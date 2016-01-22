public with sharing class extensionsEx
{
public Contact contact {get; set; }
Task task;
public extensionsEx(ApexPages.StandardController controller)
{
this.task = (Task)controller.getRecord();
/*this.contact = [select AccountId,Id,Phone,Email,OwnerId from Contact where id=:task.whoid];
string strWhatId = contact.AccountId;
task.whatid = strWhatId;
task.ownerid = contact.OwnerId;*/
}
}
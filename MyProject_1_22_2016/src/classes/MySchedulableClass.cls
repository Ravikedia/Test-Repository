global class MySchedulableClass implements Schedulable{
    global void execute(SchedulableContext ctx){
        CronTrigger ct=[SELECT ID,CronExpression, TimesTriggered,NextFireTime FROM CronTrigger Where Id=:ctx.getTriggerId()];
            System.debug(ct.CronExpression);
            System.debug(ct.TimesTriggered);
            
     Merchandise__c m=new Merchandise__c(Name='Scheduled Job Item', Description__c='Created by the Scheduler', Price__c=1, Total_inventory__c=1000);
     insert m;
     }
     }
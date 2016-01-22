@isTest
private class TestSchedulableClass {
    public static String CRON_EXP ='0 0 0 0 3 15 3 ? 2022';
    static testmethod void test(){
    
        Test.startTest();
        String jobId=System.schedule('ScheduleApexClassTest', CRON_EXP, new MySchedulableClass());
        CronTrigger ct=[SELECT Id, CronExpression, TimesTriggered, NextFireTime From CronTrigger Where id=:jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        Merchandise__c[] m1=[SELECT Id FROM Merchandise__c WHERE Name= 'Scheduled Job Item'];
        System.assertEquals(m1.size(), 0);
        m1=[select Id from merchandise__c where Name='Schedule Job Item'];
        System.assertEquals(m1.size(), 1);
        }
}
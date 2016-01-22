trigger HelloWorldTrigger on Book__c (Before insert , Before update )
{
     Book__c[] books = Trigger.new;
     System.debug('Books is'+books);
     System.debug('Trigger values is'+Trigger.new);
     MyHelloWorld.applyDiscount(books);
}
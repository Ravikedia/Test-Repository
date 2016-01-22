@isTest
public class TestclassforHerokufilesplitController implements HttpCalloutMock
{
   private HttpResponse resp;
   
   public TestclassforHerokufilesplitController(String testBody)
   {
         resp = new HttpResponse();
         resp.setBody(testBody);
         resp.setStatusCode(200);
   }
    public HTTPResponse respond(HTTPRequest req) {
        return resp;
    }
   
   
    static testMethod void myTest() 
    {
        HerokufilesplitController herokusplit=new HerokufilesplitController();
     
       
        String myString = 'StringToBlob';
        Blob myBlob = Blob.valueof(myString);
        Integer size = myBlob.size();
        herokusplit.file=myBlob;
        herokusplit.savefiel();
        herokusplit.redirect();
        herokusplit.Addtextbox();
        herokusplit.Removetextbox();
        herokusplit.Addsecondtextbox();
        herokusplit.Removesecondtextbox();
        herokusplit.refreshpage();
        
        String testBody = 'This is a test :-)';
        
       // herokusplit.radiobuttonvalue=3;
       
       
        HttpCalloutMock mock = new TestclassforHerokufilesplitController (testBody);
        Test.setMock(HttpCalloutMock.class, mock);
 
      //  demoTestWSCallouts callout = new demoTestWSCallouts();
        Test.startTest(); 
        HttpResponse resp =herokusplit.sendfiel();
        Test.stopTest();
        
        System.assertEquals(200, resp.getStatusCode());        
        System.assertEquals(resp.getBody(), testBody );
        
       // herokusplit.sendfiel();
        herokusplit.radiobuttonvalue=2;
        herokusplit.sendfiel();
     
    }
    
    
    
     static testMethod void myTestHeroku() 
    {
        HerokufilesplitController herokusplitcons=new HerokufilesplitController();
     
       
        String myStringvalue = 'StringToBlob=';
        Blob myBlobvalue = Blob.valueof(myStringvalue );
        Integer sizeoffile = myBlobvalue .size();
        herokusplitcons.file=myBlobvalue ;
        herokusplitcons.savefiel();
        herokusplitcons.redirect();
        herokusplitcons.Addtextbox();
        herokusplitcons.Removetextbox();
        herokusplitcons.Addsecondtextbox();
        herokusplitcons.Removesecondtextbox();
        herokusplitcons.refreshpage();
         herokusplitcons.radiobuttonvalue=2;
        
        String testBody = 'Please enter  less value :-)';
        
       // herokusplit.radiobuttonvalue=3;
       
       
        HttpCalloutMock mockclass = new TestclassforHerokufilesplitController (testBody);
        Test.setMock(HttpCalloutMock.class, mockclass );
 
      //  demoTestWSCallouts callout = new demoTestWSCallouts();
        Test.startTest(); 
        HttpResponse respons =herokusplitcons.sendfiel();
        Test.stopTest();
        
        System.assertEquals(200, respons .getStatusCode());        
        System.assertEquals(respons .getBody(), testBody );
        
       // herokusplit.sendfiel();
      
    }
    
    
    
    
     static testMethod void myTestHerokuseconfd() 
    {
        HerokufilesplitController herokusplitconss=new HerokufilesplitController();
     
       
        String myStringvalue1 = 'StringToBlob';
        Blob myBlobvalue1 = Blob.valueof(myStringvalue1  );
        Integer sizeoffiles = myBlobvalue1 .size();
        herokusplitconss.file=myBlobvalue1 ;
        herokusplitconss.savefiel();
        herokusplitconss.redirect();
        herokusplitconss.Addtextbox();
        herokusplitconss.Removetextbox();
        herokusplitconss.Addsecondtextbox();
        herokusplitconss.Removesecondtextbox();
        herokusplitconss.refreshpage();
         herokusplitconss.radiobuttonvalue=1;
        
        String testBody = 'Please enter  less value :-)';
        
       // herokusplit.radiobuttonvalue=3;
       
       
        HttpCalloutMock mockclasss = new TestclassforHerokufilesplitController (testBody);
        Test.setMock(HttpCalloutMock.class, mockclasss );
 
      //  demoTestWSCallouts callout = new demoTestWSCallouts();
        Test.startTest(); 
        HttpResponse responss =herokusplitconss.sendfiel();
        Test.stopTest();
        
        System.assertEquals(200, responss .getStatusCode());        
        System.assertEquals(responss .getBody(), testBody );
        
       // herokusplit.sendfiel();
      
    }
    
    
    
     static testMethod void myTestHerokuthird() 
    {
        HerokufilesplitController herokusplitconsss=new HerokufilesplitController();
     
       
        String myStringvalue2 = 'StringToBlob';
        Blob myBlobvalue2 = Blob.valueof(myStringvalue2 );
       // Integer sizeoffilesss= myBlobvalue1 .size();
        herokusplitconsss.file=myBlobvalue2;
        herokusplitconsss.savefiel();
        herokusplitconsss.redirect();
        herokusplitconsss.Addtextbox();
        herokusplitconsss.Removetextbox();
        herokusplitconsss.Addsecondtextbox();
        herokusplitconsss.Removesecondtextbox();
        herokusplitconsss.refreshpage();
         herokusplitconsss.radiobuttonvalue=0;
        
        String testBody = 'Please enter  less value :-)';
        
       // herokusplit.radiobuttonvalue=3;
       
       
        HttpCalloutMock mockclassss = new TestclassforHerokufilesplitController (testBody);
        Test.setMock(HttpCalloutMock.class, mockclassss );
 
      //  demoTestWSCallouts callout = new demoTestWSCallouts();
        Test.startTest(); 
        HttpResponse responsss =herokusplitconsss.sendfiel();
        Test.stopTest();
        
        System.assertEquals(200, responsss .getStatusCode());        
        System.assertEquals(responsss.getBody(), testBody );
        
       // herokusplit.sendfiel();
      
    }
}
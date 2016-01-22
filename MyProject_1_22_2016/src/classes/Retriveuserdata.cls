public with sharing class Retriveuserdata
{
	
	/*static public List<items> data{get; set;}
	static public void  userdata()
	{
		System.debug('yes i am called');
		
		 data = new List<items>();
        
      //  selfrecord=new List<String>();
        
        HttpRequest req=new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://graph.facebook.com/me?access_token='+accesstoken);
        HttpResponse res = null;
        http h= new Http();
        res= h.send(req);
        
        String record=res.getbody();
        
        system.debug( '----------self detaiil-------- '+res.getbody());
         String id;
         String email;
         String bio;
           JSONParser parser = JSON.createParser(record);
            while (parser.nextToken() != NUll)
           {    
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                
            {
                String text = parser.getText();
                if (parser.nextToken() != JSONToken.VALUE_NULL)
                    
                {
                    if (text == 'id')
                   {
                      id= parser.getText();
                      // selfrecord.add(id);
                      
                   }
                    
                     if (text == 'email')
                     {
                        email= parser.getText();
                       // selfrecord.add(gender);
                       System.debug('your email id is'+email);
                      
                     }
                      
                     if (text == 'bio')
                     {
                       bio= parser.getText();
                     //  selfrecord.add(name);
                       
                     }
                     
                    
                    
                     
                }
            }
      
       
           }
              data.add(new items(id,email,bio));
         return data;
	}
	
	  public class items{
        public String id { get; set; }
        public String email{get; set;}
        public String bio{get; set;}
        public String friendname{get; set;}
        public String friendid{get;set;}
       
      //  public String interest { get; set; }
       // public String whendt { get; set; }
         
        public items( String id, String email,String bio) {
            this.id = id;
            this.email=email;
            this.bio=bio;
            System.debug('------------------id is------------------'+id);
           // this.interest= interest;
          //  this.whendt = whendt;
        }
        
	  } */
}
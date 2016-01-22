public class fbcontroller
{
    //Fetched from URL
    private String code ;
    //private string clientid = '506982856097461' ;
   // private string secret = 'e61b8778ffded0e1af0f4378f913838e' ;
   // private string redirect_uri = 'https://c.ap1.visual.force.com/apex/face' ;
    private string clientid;
    private string secret;
    private string redirect_uri;
    private String accesstoken ;
    private  String expiresIn ;
    //private String tokentype;
    public  List<items> feeds;
    public List<items> data{get; set;}
    public String message{get; set;}
    public blob file{get; set;}
    public String filetype{get; set;}
    public String filename{get; set;}
    public List<Userphotos> photos{get;set;}
    public List<Usertagphotos> tagphotos{get; set;}
    public List<Userbooks> books{get; set;}
    public List<Usermovie> movie{get; set;} 
    public List<Usertelevision> tv{get; set;}
    public List<Userstatus> ustatus{get; set;}
    public List<WrapperUserevents> events{get; set;}
    public Integer flag{get; set;}
  
    
   // private String token;
    public fbcontroller()
    {
    	// List<fbintegration__c> mcs = fbintegration__c.getall().values();
        //retriving data from cusyom setting
        List<fbintegration__c> record=[select Clientid__c, secret__c, redirect_uri__c from fbintegration__c where Name='integration' limit 1];
        // List<fbintegration__c> record= Database.query(query);
        
      for(fbintegration__c str: record)
      {
         clientid=str.Clientid__c;
         secret=str.secret__c;
         redirect_uri=str.redirect_uri__c;
         
      }
       
        flag=0;
        
        code = ApexPages.currentPage().getParameters().get('code') ;
        System.debug('----------------------------------------------------------------'+code);
        //Get the access token once we have code
        if(code != '' && code != null)
        {
            AccessToken() ;
        }
    }
    
    public PageReference fbAuth()
    {
        
         PageReference pg = new PageReference(FacebookAuthUri (clientid , redirect_uri)) ;
         return pg ;
        
    }
    
   /* public List<items> getFeeds() {
        
        System.debug('-----------------------------feeds---------------------------------------'+feeds);
        return feeds;
    }*/
    
   
    
    public String FacebookAuthUri(String Clientkey,String redirect_uri)
    {
        // String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        //String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        // String state='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        String authuri = '';
        authuri='https://www.facebook.com/dialog/oauth?client_id=506982856097461&redirect_uri='+redirect_uri+'&scope=user_about_me,read_mailbox,read_insights,user_photos,email,friends_photos,publish_stream,read_friendlists,read_insights,read_requests,read_stream,xmpp_login,ads_management,publish_actions,create_event,manage_friendlists,manage_friendlists,user_friends,manage_notifications&state=SOME1956576';
       // authuri='https://www.facebook.com/dialog/oauth?client_id=506982856097461&redirect_uri=https://ap1.salesforce.com/apex/Authservices&scope=user_about_me,read_mailbox,read_insights,user_photos,friends_photos,publish_stream,read_friendlists,read_insights,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,&state=SOME1956576'; 
        //authuri='https://www.facebook.com/dialog/oauth?client_id=407057492687428&redirect_uri=https://chinnichinni-dev-ed.my.salesforce.com/apex/sts1&scope=user_about_me,read_mailbox,read_insights,user_photos,friends_photos,publish_stream,read_friendlists,read_insights,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,&state=SOME555555'; 
        return authuri;
    }

    public void AccessToken()
    { 
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        //req.setEndpoint('https://graph.facebook.com/oauth/access_token');
        req.setEndpoint('https://graph.facebook.com/oauth/access_token?client_id=506982856097461&redirect_uri=https://c.ap1.visual.force.com/apex/face&client_secret=e61b8778ffded0e1af0f4378f913838e&code='+code+'#_=_'); 
        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
        Integer len=resp.length();
        System.debug('------'+len);
        
        Integer startindex=13;
        Integer lastindex=len-16;
               
        accesstoken=resp.subString(startindex,lastindex);
        System.debug('----------------access token is-----------------'+accesstoken);
        expiresIn=resp.subString(lastindex+9,len);
        System.debug('---------expirein-------------'+expiresIn);
        System.debug(' You can parse the response to get the access token ::: ' + resp);
    }

      //Retrive self data
	public PageReference retriveData()
    {
         
    	// Retriveuserdata.userdata()
    	flag=1;
        data = new List<items>();
     
        HttpRequest req=new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://graph.facebook.com/me?access_token='+accesstoken);
        HttpResponse res = null;
        http h= new Http();
        res= h.send(req);
        String record=res.getbody();
        system.debug( '----------self detaiil-------- '+res.getbody());
        String id,email,bio;
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
                    }    
                    if (text == 'email')
                    {
                        email= parser.getText(); 
                    }
                    if (text == 'bio')
                    {
                        bio= parser.getText();
                    }   
                 }
             }
       }
                     data.add(new items(id,email,bio));
                     return null;
         
       }
       public void publishedPost()
       {
        
         
            System.debug('-----------------------------------------------'+message);
           // String bodyEncoded = EncodingUtil.base64Encode(message);
            HttpRequest req=new HttpRequest();
           
            message =   EncodingUtil.urlEncode(message, 'UTF-8');
            
            // req.setbody(message);
            //req.setheader('Content-type', 'application');
            // req.setheader('Content-length', String.valueOf(message.length()));
           // req.setEndpoint('https://graph.facebook.com/me/feed?message="'+message+'"&access_token={'+accesstoken+'}');
            
           // req.setHeader('Cache-Control', 'no-cache') ;
            req.setMethod('POST');
            //system.debug('');
            req.setEndpoint('https://graph.facebook.com/v2.0/me/feed?message='+message+'&access_token='+accesstoken);
            //req.setEndpoint('https://graph.facebook.com/v2.0/me/feed?message="Heaasdfasdfasdfasdllo"&access_token=CAAHNGSULfrUBANoxZB1OUrorcap9RH6FAJM4r0fwZBlvVVEKXzLuE1oSVDO8VHRHysr2kOy4JCNKGZAL0S5htJu54bZCCdAKdSBqf4ss4d62cKfiM3tgpMYptYV7rEcECkmcF7fHXrcZCv4sERSbkYsUgBPea3STn6JIXEv9TaUDwWZBraLN7cGQIIZANpjzU8ZD');
             
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req); 
            system.debug('---------message idddddddddddddddddsssssssss---------'+res.getbody());
        
        
       }
       
       
       public void uploadPhoto()
       {
            
             
             String bodyEncoded = EncodingUtil.base64Encode(file);
            // System.debug('------------------------------------------'+bodyEncoded);
            // bodyEncoded = bodyEncoded ;
            //
            String boundary = '-------314159265358979323846';
            /// String delimiter = '\r\n--' + boundary +'\r\n';
            // String close_delim = '\r\n--' + boundary;
            // String message=''

             String body=boundary +'\r\n'+
            'Content-Disposition:form-data; name="source";filename="'+filename+'"\r\n'+
            'Content-Type: '+filetype+'\r\n'+
             bodyEncoded +'\r\n'+
             boundary;
            // String encoded = EncodingUtil.urlEncode(body, 'UTF-8');
        
           // System.debug('----------------------------------body is-------------\n'+body);
            HttpRequest req=new HttpRequest();
            req.setMethod('POST');
            //req.setbody(body);
            
           req.setHeader('Content-Type', 'multipart/form-data ; boundary="'+boundary+'"');
          // req.setHeader('Content-length', String.valueOf(body.length()));
            
           	//req.setheader('Content-type', 'application/x-www-form-urlencoded');
          	req.setHeader('Content-length',string.valueof(body.length()) );
          // req.setHeader('Content-Encoding','base64');
            req.setTimeout(60000);
           	req.setEndpoint('https://graph.facebook.com/v2.0/me/photos?access_token='+accesstoken );
            
            HttpResponse res = null; 
            http h= new Http();
            res= h.send(req);    
            system.debug( '------------upload photo----------------------'+res.getbody());    
           // string sss='URL=http://www.vahrehvah.com/indianfood/wp-content/uploads/2010/11/JawaharlalNehru.jpg';
           // req.setbody(sss);

			//upload photo on facebook
          /* <apex:Page>
		      <html>
		          <body>
		              <form enctype="multipart/form-data" action="https://graph.facebook.com/v2.0/me/photos?access_token=CAAHNGSULfrUBAP35ZAhuTlo1JnAYRmtLjCGlWZCO0yt3a8r8EDoQlyZCFRUlX2LoQYy646oKPCC9vyWCjWXqMkyXgTooR8pbtp2NMnPtirSORIbQCMWMJgrCvYgWJYekcd9p29uk2EKMYtNhZBcZBwPhZATvgTZB7ZCIogr60RLmYjIuzsQJP2hwov6nlZAdhfnnhgIqksjYwmJdoN00UohqO" method="POST" >
		                  Please choose a photo: <input name="source" type="file" /><br/><br/>
		                  Say something about this photo: 
		                  <input name="message" type="text" value="" /><br/><br/>
		                  <input type="submit" value="Upload" /><br/>
		              </form>
		          </body>
		      </html>     
			</apex:page>*/
			
			//Upload video on facebook
			
			/*https://developers.facebook.com/blog/post/493

			<form enctype="multipart/form-data" action="https://graph-video.facebook.com/me/videos?access_token=CAAHNGSULfrUBAP35ZAhuTlo1JnAYRmtLjCGlWZCO0yt3a8r8EDoQlyZCFRUlX2LoQYy646oKPCC9vyWCjWXqMkyXgTooR8pbtp2NMnPtirSORIbQCMWMJgrCvYgWJYekcd9p29uk2EKMYtNhZBcZBwPhZATvgTZB7ZCIogr60RLmYjIuzsQJP2hwov6nlZAdhfnnhgIqksjYwmJdoN00UohqO" method="POST" >
				Please choose a file:
					<input name="file" type="file">
 					<input type="submit" value="Upload"  />    
 			</form>*/
			
            
            
       }
       
       public void Books()
       {
        
             flag=3;
            books=new List<Userbooks>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/books?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------friends list----------'+res.getbody());
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            String id;
            String name;
            Integer k=0,l=0;
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                      if(text=='name' || text=='id')
                      {
                        if (text == 'name')
                        {
                            name= parser.getText();
                           k++;
                        }
                        if(text=='id')
                        {
                        id=parser.getText();
                            l++;
                        } 
                        if( k==l && k!=0 && l!=0)
                         {  
                             books.add(new Userbooks(name,id));
                         }
                      }
                    }
                    
                }
                
              }
        
        
       }
       
       
       
       
       
       
          public void Userevents()
         {
        
             flag=9;
           // books=new List<Userbooks>();
            events=new List<WrapperUserevents>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/events?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------events detail----------'+res.getbody());
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            String id;
            String name,location;
            Integer k=0,l=0,m=0;
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                      if(text=='name' || text=='id' || text=='location')
                      {
                        if (text == 'name')
                        {
                            name= parser.getText();
                           k++;
                        }
                        if(text=='id')
                        {
                        id=parser.getText();
                            l++;
                        } 
                        if(text=='location')
                        {
                            location=parser.getText();
                        }
                        if( k==l && k!=0 && l!=0)
                         {  
                             events.add(new WrapperUserevents(name,id,location));
                         }
                      }
                    }
                    
                }
                
              }
        
        
       }
       
       
         public void Movies()
       {
           flag=0;
           flag=4;
            movie=new List<Usermovie>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/movies?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------movie list----------'+res.getbody());
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            String id;
            String name;
            Integer k=0,l=0;
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                      if(text=='name' || text=='id')
                      {
                        if (text == 'name')
                        {
                            name= parser.getText();
                           k++;
                        }
                        if(text=='id')
                        {
                        id=parser.getText();
                            l++;
                        } 
                        if( k==l && k!=0 && l!=0)
                         {  
                             movie.add(new Usermovie(name,id));
                         }
                      }
                    }
                    
                }
                
              }
        
        
       }
       
            public void Television()
            {
            flag=5;
            tv=new List<Usertelevision>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/television?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------movie list----------'+res.getbody());
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            String id;
            String name;
            Integer k=0,l=0;
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                      if(text=='name' || text=='id')
                      {
                        if (text == 'name')
                        {
                            name= parser.getText();
                           k++;
                        }
                        if(text=='id')
                        {
                        id=parser.getText();
                            l++;
                        } 
                        if( k==l && k!=0 && l!=0)
                         {  
                             tv.add(new Usertelevision(name,id));
                         }
                      }
                    }
                    
                }
                
              }
              
          
       }
      
      
      
            public void Status()
            {
             flag=7;
            ustatus=new List<Userstatus>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/statuses?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------movie list----------'+res.getbody());
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            String id;
            String message;
            String updatetime;
            Integer k=0,l=0,m=0;
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                      if(text=='message' || text=='id'|| text=='updated_time')
                      {
                        if (text == 'message')
                        {
                            message= parser.getText();
                           k++;
                        }
                        if(text=='id')
                        {
                        id=parser.getText();
                            l++;
                        } 
                        if(text=='updated_time')
                        {
                            
                            updatetime=parser.getText();
                            m++;
                              
                        }
                        if( k==m && k!=0 )
                        {
                            
                            ustatus.add(new Userstatus(message,id,updatetime));
                            k=0;
                            m=0;
                        }
                        
                            
                           
                         
                      }
                    }
                    
                }
                
              }
              
          
       }
      
       public void retriveFriendData()
       {
           integer i=0;
           flag=2;
          // friendsrecord=new List<string>();
           data = new List<items>();

            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/taggable_friends?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------friends list----------'+res.getbody());
            String record=res.getbody();
            String friendid;
            String friendname;
            JSONParser parser = JSON.createParser(record);
            System.debug('==============='+parser);
           Integer value=0;
           Integer k=0;
           Integer l=0;
            while (parser.nextToken()  != null)
            {    
                System.debug('-------'+(value++));
                
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                        
                       if(text=='name' || text=='url')
                       {
                        if (text == 'name')
                        {
                            friendname= parser.getText();
                            //friendsrecord.add(friendname);
                            k++;
                        }
                        if (text == 'url')
                        {
                            friendid= parser.getText();
                           // friendsrecord.add(friendid);
                            l++;
                        }
                        
                         if( k==l && k!=0 && l!=0)
                         {
                             data.add(new items(friendid,friendname)); 
                              
                         }
                    }
                    }
                     
                   
                
                }
                
               
                
           }
           
       }
       
       public void albumPhoto()
       {
           flag=6;
            tagphotos=new List<Usertagphotos>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/photos?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------Album photo----------'+res.getbody());
            String tagpicture;
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            while (parser.nextToken()  != null)
              {
                 if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                 {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                        if (text == 'picture')
                        {
                            tagpicture= parser.getText();
                           // uploadphoto.add(picture);
                            tagphotos.add(new Usertagphotos(tagpicture));
                          
                        }
                    }
                    
                }
                
               
              }
              
        
       }
       
        public void publishedPhoto()
        {
            // uploadphoto=new List<string>();
            // data = new List<items>();
            flag=8;
                  photos= new List<Userphotos>();
            HttpRequest req=new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://graph.facebook.com/me/photos/uploaded?access_token='+accesstoken);
            HttpResponse res = null;
            http h= new Http();
            res= h.send(req);
            system.debug('----------self  photo----------'+res.getbody());
            String picture;
            String record=res.getbody();
            JSONParser parser = JSON.createParser(record);
            
             while (parser.nextToken()  != null)
              {    
               
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL)
                    {
                        if (text == 'picture')
                        {
                            picture= parser.getText();
                           // uploadphoto.add(picture);
                            photos.add(new Userphotos(picture));
                          
                        }
                    }
                    
                }
                
               
              }
              
        }
       
    
       //pass coments to the facebook
       public void passComents()
       {
           
             HttpRequest req=new HttpRequest();
              req.setMethod('POST');
             string sss='message=hai ra mama';
             sss =   EncodingUtil.urlEncode(sss, 'UTF-8');
             req.setbody(sss);
             req.setheader('Content-type', 'application/x-www-form-urlencoded');
             req.setHeader('Content-length',string.valueof(sss.length()) );
             req.setEndpoint('https://graph.facebook.com/456267301143670/comments?access_token='+accesstoken);
             HttpResponse res = null;
             http h= new Http();
             res= h.send(req);    
             system.debug( 'haiiiiiiiiiiiiiiiii'+res.getbody());
             

      }
       
       public class items
       {
            public String id { get; set; }
            public String email{get; set;}
            public String bio{get; set;}
            public String friendname{get; set;}
            public String friendid{get;set;}
       
      //  public String interest { get; set; }
       // public String whendt { get; set; }
         
            public items( String id, String email,String bio)
            {
                this.id = id;
                this.email=email;
                this.bio=bio;
                System.debug('------------------id is------------------'+id);
               // this.interest= interest;
              //  this.whendt = whendt;
            }
        
            public items(String friendid, String friendname)
            {
                this.friendid=friendid;
                this.friendname=friendname;
            
            }
       
        }
     public class Userphotos
     {
        
        public String picture{get;set;}
        public Userphotos(String picture)
        {
            this.picture=picture;
        }
     }
    public class Usertagphotos
    {
        public String tagphotos{get; set;}
        public Usertagphotos(String tagphotos)
        {
        
            this.tagphotos=tagphotos;   
        }
    }
    public class Userbooks
    {
        public String name{get;set;}
        public String id{get; set;}
        public Userbooks(String name, String id)
        {
        this.name=name;
        this.id=id; 
            
        }   
        
    }
    
        public class Usermovie
        {
            public String name{get;set;}
            public String id{get; set;}
            public Usermovie(String name, String id)
            {
            this.name=name;
            this.id=id; 
                
            }
        }
        public class Usertelevision
        {
            
            public String name{get;set;}
            public String id{get; set;}
            public Usertelevision(String name, String id)
            {
            this.name=name;
            this.id=id; 
                
            }
        }
        
        public class Userstatus
        {
            
            public String message{get;set;}
            public String id{get; set;}
            public String updatetime{get; set;}
            public Userstatus(String message, String id, String updatetime)
            {
            this.message=message;
            this.id=id; 
            this.updatetime=updatetime;
                
            }
       
        }
        
        
          public class WrapperUserevents
        {
            
            public String name{get;set;}
            public String id{get; set;}
            public String location{get; set;}
           
            public WrapperUserevents(String name, String id,String location)
            {
                this.name=name;
                this.id=id; 
                this.location=location;
            
                
            }
       
        }

}
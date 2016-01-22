public class FileUploader 
{
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    public String searchid{get; set;}
    List<Account > acc;
    public List<String> showrows;
  //  public String SearchrecordonAccount{get; set;}
    String[] filelines = new String[]{};
    List<Account> accstoupload;
    
    public void ReadFile()
    {
        showrows=new List<String>();
        nameFile=contentFile.toString();
        filelines = nameFile.split('\n');
       // List<List<String>> stringlist= nameFile.split('\n').split(',');
        
        
        List<List<String>> csvList = new List<List<String>>();
         //String[] inputvalues = new String[]{};
        for(String line : filelines)
    	{
	    	
	    	System.debug('Line is:::::::::::::::::::::::::::::'+line);
	    	String[] linePieces = line.split(',');
	    	//Integer len=linePieces.size();
	    	System.debug('Line pieces is:::::::::::::::::::::::::::::'+linePieces);
	    	List<String> csvPieces = new List<String>(linePieces.size());
	    	//inputvalues = filelines[i].split(',');
	    	//List<String> csvPieces = new ArrayList<String>(linePieces.length);
    		for(String piece : linePieces)
    		{
    			csvPieces.add(piece);
    			System.debug('csvPieces pieces is:::::::::::::::::::::::::::::'+piece);
    		    System.debug('Actual pieces is:::::::::::::::::::::::::::::'+csvPieces);
				System.debug('csvPieces pieces is:::::::::::::::::::::::::::::'+linePieces);
    		}
    		csvList.add(csvPieces);
    		System.debug('------888888888------------------'+csvPieces);
	    	System.debug('-------777777777-----------------'+csvList);
	    	
    	}  
    	
  
      accstoupload = new List<Account>();
       for (Integer i=0;i<filelines.size();i++)
        {  
            String[] inputvalues = new String[]{};
            System.debug('############################'+filelines);
            inputvalues = filelines[i].split(',');
          //  String row=
          
           // showrows.add(inputvalues);
            
           // System.debug('******************************'+inputvalues.);
            Account a = new Account();
           // a.id='abcdefghijklmn'+i;
            a.Name = 'abc'+i;
            a.ShippingStreet = inputvalues[1];       
            a.ShippingCity = inputvalues[2];
            a.ShippingState = inputvalues[3];
            a.ShippingPostalCode = inputvalues[4];
            a.ShippingCountry = inputvalues[5];
            accstoupload.add(a);  
        }   
       // return null;
    }
  
   public List<Account> getuploadedAccounts()
    {
        if (accstoupload!= NULL)
            if (accstoupload.size() > 0)
                return accstoupload;
            else
                return null;                    
        else
            return null;
    }   
    public void SearchrecordonAccount() 
    {
        acc=new List<Account>();
        for(Account a : accstoupload )
        {
            System.debug('***********'+a);
            if(a.name==searchid)
            {
                Account accnt=new Account();
                accnt.Name=a.name;
                accnt.ShippingStreet=a.ShippingStreet;
                accnt.ShippingCity=a.ShippingCity;
                accnt.ShippingState=a.ShippingState;
                accnt.ShippingPostalCode=a.ShippingPostalCode;
                accnt.ShippingCountry=a.ShippingCountry;
                acc.add(accnt);
                
            }
        }
    }   
    
    public List<Account > getrecords()
    {      
        return acc;
    }
}
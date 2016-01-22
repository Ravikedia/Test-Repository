public class uploadCSVcontroller {

    public Blob contentFile { get; set; }
    public String nameFile { get; set; }
    public Integer rowCount { get; set; }
    public Integer colCount { get; set; }
    public String searchid{get; set;}
    public List<List<String>> retriveList;
    public List<List<String>> searchList;
   // public Map<String, List<String> > mapvalues;
    
    public uploadCSVcontroller()
    {
        retriveList=new List<List<String>>();
      //  mapvalues=new Map<String, List<String>>();       
    }
  
    public List<List<String>> getResults()
    {
        List<List<String>> parsedCSV = new List<List<String>>();
        rowCount = 0;
        colCount = 0;
        if (contentFile != null)
        {
            String fileString = contentFile.toString();
            parsedCSV = parseCSV(fileString, false);
            retriveList=parsedCSV;
            rowCount = parsedCSV.size();
            for (List<String> row : parsedCSV)
            {
                if (row.size() > colCount)
                {
                    colCount = row.size();
                }
            }
        }
        return parsedCSV;
    }
    
    public void searchRecord() 
    {
        searchList=new List<List<String>>();
        for(List<String> lof : retriveList) 
        {   
            if(lof[0].trim()==searchid )
            {
                searchList.add(retriveList[0]);
                searchList.add(lof);
            }
        }
        
      /*  for(String svalues : mapvalues.keyset())
        {
           List<String> svalue= mapvalues.get(svalues);
           if(svalue[0].trim()==searchid )
           {
               System.debug('****svalues[0]********'+svalue[0].trim());
              // searchList.add(svalue[0].trim());
               searchList.add(svalue);
               
           }
           System.debug('****svalues*********'+svalue);
        }*/
        
    }
    
    public List<List<String>> getResultList()
    {   
        return searchList;
    }
    
    public List<List<String>> parseCSV(String contents,Boolean skipHeaders)
    {
        List<List<String>> allFields = new List<List<String>>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
      
        List<String> lines = new List<String>();
        try
        {
            //lines = contents.split('\n'); //correction: this only accomodates windows files
            lines = contents.split('\r'); // using carriage return accomodates windows, unix, and mac files
        
        } 
        catch (System.ListException e)
        {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;
        for(String line: lines)
        {
            if (line.replaceAll(',','').trim().length() == 0) break;
            
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field: fields)
            {
                cleanFields.add(field);
            }
            //mapvalues.put(cleanFields[0], cleanFields); 
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        return allFields;       
    }
}
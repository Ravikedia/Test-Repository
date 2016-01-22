public class multiselect {
 
    Set<String> originalvalues = new Set<String>{'A','B','C','D','E','F','G','H','I','H','I','j','k','L','M','N'};
    Public List<string> leftselected{get;set;}
    Public List<string> rightselected{get;set;}
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>();
   // List<String> storevalue{get;set;}
     
    public multiselect(){
        leftselected = new List<String>();
        rightselected = new List<String>();
        leftvalues.addAll(originalValues);
       
    }
     
    public PageReference selectclick(){
       // rightselected.clear();
        for(String s : leftselected)
        
        {
           System.debug('------------------left---------------------'+leftselected.size());
           
            leftvalues.remove(s);
            rightvalues.add(s);
        }
        return null;
    }
     
    public PageReference unselectclick(){
        //leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        return null;
    }
    
    public PageReference upselectclick()
    {
     Integer flag=0;
     String storevalue;
     for(String s : rightvalues)
     {
            
          Integer totalrightelement=rightvalues.size();
          Integer totalrightselectvalue=rightselected.size();
          rightvalues.add(s);
          flag++;
  
  
        
           if(flag==(totalrightelement-totalrightselectvalue))
           {
               System.debug('-----------------------------called');
               storevalue=s;
               rightvalues.remove(s);
           }
          
     }
    
         rightvalues.add(storevalue);
        
        
        
     System.debug('---------------------right------------------'+rightselected.size());
      System.debug('------------------left---------------------'+leftselected.size());
     integer listsize;
     integer selectlistsize;
     System.debug('---------------------------------------outside-----------');
   
            //leftvalues.remove(s);
         //  rightvalues.remove();
        
  /* for(Integer i=0;i<rightselected.size(); i++)
   {
           selectlistsize= rightselected.size();
         listsize=getSelectedValues().size();
        System.debug('---------------------------------------'+rightselected.get(i));
        System.debug('---------------------------------------'+rightselected.size());
        System.debug('---------------------------------------'+getSelectedValues().get(listsize- selectlistsize-1));
        
      // getSelectedValues().get(listsize- selectlistsize-1);
    
        //rightvalues.remove(rightselected.get(i));
       // rightvalues.add(rightselected.get(i));
    
   }*/
   
   // getSelectedValues();
    return null;
    }
    public PageReference downselectclick()
    {
    System.debug('down clicked');
    return null;
    }
 
    public List<SelectOption> getunSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
 
    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
}
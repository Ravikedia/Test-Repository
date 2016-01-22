public  class Typeahead
{

  public String seloptions {get; set;}
  public String searchvalue{get; set; }
  public List<Sobject> recordList{get; set;}
  
  public PageReference PickValueChange()
  {
  return null;
  }
  
  
  
  public List<SelectOption> getName()
  {

        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();    
    
        List<SelectOption> options = new List<SelectOption>();
        options.add(new selectoption('---None---', '---None---'));
        for(String obj : gd.keyset())
        {
           
           Schema.DescribeSObjectResult r = gd.get(obj).getDescribe();
           options.add(new SelectOption(r.getName(),r.getLabel()));//value and labell
    
        }  
         
          return options;

   }
}
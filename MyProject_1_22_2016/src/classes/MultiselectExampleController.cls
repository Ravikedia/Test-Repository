public with sharing class MultiselectExampleController {

    public SelectOption[] selectedContacts { get; set; }
    public SelectOption[] allContacts { get; set; }
     //Set<String> originalvalues = new Set<String>{'A','B','C','D','E','F','G','H','I','H','I','j','k','L','M','N'};
    
    public String message { get; set; }
    
    public MultiselectExampleController() {
        selectedContacts = new List<SelectOption>();
        
        List<Contact> contacts = [SELECT Name, Id FROM Contact];
        contacts.sort();    
        allContacts = new List<SelectOption>();
        for ( Contact c : contacts )
         {
            allContacts.add(new SelectOption(c.Id, c.Name));
           
            
                 
        }
         System.debug('-------------------------------------------------------'+allContacts);
       // allContacts.sort();
      //  System.debug('-------------------------------------------------------'+allContacts);
    }

    public PageReference save() {
     
        
        return null;       
    }
}
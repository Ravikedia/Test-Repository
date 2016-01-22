public class SearchController{
    
    /**class variable to store values at class level**/
    private List<SelectOption> lstObjectOptions ;   
    /**variable to store fields as per selected object at ui level **/
    private List<string> fields ;
    /** variable bind with search textbox **/
    public string searchString {get;set;}
    /** variable contain selected value of object dropdown **/
    public string SelectedSobject {get;set;}
    /** variable which will hold the state of rows for pagination **/
    private ApexPages.StandardSetController con ;
    /** list variable which will bind with VF page **/
    public List<Sobject> currentViewList {get;set;}
    
    
    /** property which contain list of items for select dropdown **/
    public List<SelectOption> ObjectList{
        get{
            if(lstObjectOptions ==null){
                lstObjectOptions = new List<SelectOption>();
                lstObjectOptions.add(new SelectOption('Account','Account'));
                lstObjectOptions.add(new SelectOption('Contact','Contact'));
                
            }
            return lstObjectOptions;
            }   
        set;
    }
    
    
    /**Constructor for this controller **/
    public SearchController(){
      currentViewList = new List<Sobject>();
      //default value of object to search
      SelectedSobject ='Account';
    
      
    }
    
     
    /** List contains fields of contact to show on VF page **/
    public List<String> getFields{
        get{
            fields = new List<String>();
           if(SelectedSobject=='Account'){
              fields.add('Name');
              fields.add('Ownerid');
              fields.add('Website');
              fields.add('Phone');
              fields.add('Fax');
              
            }
            else{
              
              fields.add('FirstName');
              fields.add('LastName');
              fields.add('Email');
              fields.add('Fax');
              fields.add('Phone');
                
                
            }
            return fields;
            
        }
        set;
    }
    /** Method to get data result based on search word and on click on search button **/
    public void searchData(){
        
        
        String querySOSL='';
        String querySQL=''; 
        system.debug('==='+SelectedSobject );
        currentViewList.clear();
        String queryFields = getQueryFields(this.getFields);
        queryFields = 'id,' + queryFields ;
        
        if(SelectedSobject=='Account'){
            querySQL = 'select ' + queryFields + ' from Account';
            querySOSL = 'FIND\'' + searchString + '*\'IN ALL FIELDS RETURNING Account(' + queryFields + ')';
        }
        else{
            querySQL = 'select ' + queryFields + ' from Contact';
            querySOSL = 'FIND\'' + searchString + '*\'IN ALL FIELDS RETURNING Contact(' + queryFields + ')';
        }
        
        
        system.debug('====='+QuerySOSL);
        
        List<List<SObject>>  resultListOfList= search.query(querySOSL);
        system.debug('==='+resultListOfList);
        
        if(resultListOfList[0] !=null && resultListOfList[0].size()>0){
             
             querySQL = querySQL + ' where id in (' + getRecordIds(resultListOfList[0]) + ')';
             system.debug('====='+QuerySQL);
             con = new ApexPages.StandardSetController(Database.getQueryLocator(querySQL));
             Con.setPageSize(5);
            for(SObject nextRec : (List<SObject>)Con.getRecords()){        
                currentViewList.add(nextRec);
            
            }
        }
        
    }
    
   /** method to concatenate ids of search results **/
   private string getRecordIds(List<SObject> sObjectList){
        string ids ='';integer i=0;
        for(SObject nextObj:sObjectList){
            i=i+1;
            
            if(i==1)
                ids= '\'' + nextObj.id + '\'';
            else
                ids=ids+',\''+ nextObj.id + '\'';
        }
        return ids;
    
   }
   
    /** method to concatenate fields for SOSL query as per selected object **/
    private String getQueryFields(List<String> fieldsParam){
    
      String query='' ;Integer i=0;
      for(String nextStr:fieldsParam){
        i=i+1;
        
        if(i==1)
            query=nextStr;
        else 
            query=query+ ',' + nextStr;
            
      }
      return query;
      
    
    }
    
    
    
    public Boolean hasNext {       
     get {           
     return Con.getHasNext();    
     }      
     set; 
    }  
     public Boolean hasPrevious {     
         get {         
         return Con.getHasPrevious();    
         }        
         set;   
     }    
     public Integer pageNumber {       
         get {       
         return Con.getPageNumber();     
         }      
         set;   
     }     
     public void first() {    
        Con.first();   
     } 
     
     public void last() {     
        Con.last();   
     }   
     public void previous() {      
        Con.previous();   
     }     
     public void next() {   
        Con.next(); 
     }
        
    
}
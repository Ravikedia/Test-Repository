public class somecontroller
{
Set<String> selectedDesignations= new Set<String>{'A','B','C','D','E','F','G','H','I','H','I','j','k','L','M','N'};
  Public List<string> unHighlightedDesignations{get;set;}
  public List<String> highlightedDesignations{get;set;}
  public String DESIGNATION_MOVE_DIRECTION{get;set;}
public void reOrderDesignations(){
    //re order unHighlightedDesignations(list item 0) inside the list called selectedDesignations(set)
    
    
    String SELECTED = unHighlightedDesignations.get(0);
    
    if(unHighlightedDesignations.size() == 1){
        Integer myCount = 0;
        Integer myResult;
        for(String s: selectedDesignations){
            
            if(s.equals(SELECTED)){
                myResult = myCount; 
                
                break;
            }else{
                myCount++;
            }

        }
        
        
        
        String temp;
        Integer x=0;
        //convert set to list
        List<String> items = new List<String>(selectedDesignations);
        
        if(myResult!= 0){
            if(this.DESIGNATION_MOVE_DIRECTION.equalsIgnoreCase('up')){
                x = myResult-1;
                temp = items.get(x);
                
                items[myResult] = temp;
                items[myResult-1] = SELECTED;
                
                        
            }else if(this.DESIGNATION_MOVE_DIRECTION.equalsIgnoreCase('down')){
                x = myResult+1;
                temp = items.get(x);
                items[myResult] = temp;
                items[myResult+1] = SELECTED;
            }
            
        Integer size = items.size();
        this.selectedDesignations.clear();
        //////////////////////////////////////////////////
        for(Integer y = 0; y < size;y++ ){
            this.selectedDesignations.add(items[y]);
            System.debug('Item2: '+items[y]);
        }
    
            
        }
        
        
    }
    
    }
}
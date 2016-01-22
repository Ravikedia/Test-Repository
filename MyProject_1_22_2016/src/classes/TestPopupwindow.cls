public with sharing class TestPopupwindow {

    public Boolean displayPopup {get;set;}

    public TestPopupwindow (ApexPages.StandardController controller) {

    }
    
    public void showPopup()
    {
        
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    
    public PageReference redirectPopup()
    {
         displayPopup = false;
        //Please uncomment below 3 statements and replace YourObjectId
       PageReference p=new Pagereference('/'+'popupwindow');
         p.setRedirect(true);
        return p;
        
    }
    


}
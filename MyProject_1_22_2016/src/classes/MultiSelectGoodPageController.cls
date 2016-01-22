public class MultiSelectGoodPageController
{    
    public List<SelectOption> leftOptions{get; set;}
    public List<SelectOption> rightOptions{get; set;}
    
    public MultiSelectGoodPageController()
    {
         leftOptions = new List<SelectOption>();
          for( Schema.PicklistEntry f : Opportunity.Type.getDescribe().getPicklistValues())
            leftOptions .add(new SelectOption(f.getLabel(), f.getValue()));
        rightOptions = new List<SelectOption>();

    }
}
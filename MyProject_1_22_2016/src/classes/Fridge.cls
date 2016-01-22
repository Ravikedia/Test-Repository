public class Fridge {
    private String modelNumber;
    private Integer numberInStock;
    public void setmodelNumber(String model)
    {
    modelNumber=model;
    }
    public String getmodelNumber()
    {
    return modelNumber;
    }
    public Fridge() {
        modelNumber = 'XX-XX';
        numberInStock = 0;
    }
    public Fridge(String theModelNumber, Integer theNumberInStock) {
        modelNumber = theModelNumber;
        numberInStock = theNumberInStock;
    }
    public static void toDebug(Fridge aFridge) {
    System.debug ('ModelNumber = ' + aFridge.modelNumber);
    System.debug ('Number in Stock = ' + aFridge.numberInStock);
    }
    
        
    
}
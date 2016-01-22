public class MessageSecond{
    
    public enum Season{ WINTER, SPRING,SUMMER, FALL}
    public void Test()
    {
          Integer[] myList = new List<Integer>();
        //Adds a new element with value 10 to the end of the list
           myList.add(10);
        // Retrieve the first element of the list
        // using array notation
           Integer ii = myList[0];
        // or using the get method
           Integer jj = myList.get(0);
           System.debug('First element in the array using myList[0] is ' + ii);
           System.debug('First element in the array using myList.get(0) is ' + jj);
           Map<String,String> m=new Map<String,String>{'a'=>'Apple', 'b'=>'Gourav sir'};
           System.debug(m.get('a'));
        Date myToday = Date.today();
        Date myNext30 = myToday.addDays(30);
        System.debug('myToday = ' + myToday);
        System.debug('myNext30= ' + myNext30); 
        Decimal d=19.23;
        Decimal after=d.Divide(100,3);
        System.debug(after);
        boolean b=true;
        integer i;
        Double hhshshshhsh=1717717717.24;
        System.debug(b);
        System.debug(i);
        Season s=Season.SUMMER;
        if(s == Season.SUMMER){
        System.debug(s);
        }else {
        System.debug('Not SUMMER');
        }
        for(Season ss:Season.values())
        {
        System.debug(ss);
        }
     
   
     
     }
        
        
}
public class MessageMaker {
   
    public static String hellomessage(){
        String myVariable = 'I am a string.';
        Date myDate = Date.today();
		String myString = String.valueOf(myDate);
		System.debug(myString);
        String x = 'The !shorn! sheep !sprang!.';
		System.debug (x.endsWith('.'));
		System.debug (x.length());
		System.debug (x.substring(5,10));
		System.debug (x.replaceAll ('!(.*?)!', '$1'));
    	return ('You say "Goodbye," and I say "hello" ');
    }
    




}
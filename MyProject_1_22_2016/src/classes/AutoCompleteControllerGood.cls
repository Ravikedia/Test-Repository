public with sharing class AutoCompleteControllerGood {
    
    // Instance fields
    public String searchTerm {get; set;}
    public String selectedMovie {get; set;}
    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    public static List<Account> searchMovie(String searchvalue) {
        //System.debug('Movie Name is: '+searchTerm );
        //List<Account> accountData= Database.query('Select Id, Name from Accountwhere name like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'');
        //return movies;
        
        String str='select id,Name, Phone, Type from account where name like \'%'+searchvalue+'%\' limit 25';
        List<Account> accountData =database.query(str);
        return accountData;
    }
}
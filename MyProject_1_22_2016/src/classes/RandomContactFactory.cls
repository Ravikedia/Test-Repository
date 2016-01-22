public class RandomContactFactory
{
    public static List<Contact>  generateRandomContacts(Integer no, String str)
    {
        List<Contact> listOfContact = new List<Contact>();
        for(Integer i =0; i< no; i++)
        {
            Contact con = new Contact();
            con.FirstName = 'Test'+i;
            con.LastName = str;
            listOfContact.add(con);
            
        }
        return listOfContact ;
    }
}
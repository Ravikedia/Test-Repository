public class Customer {

// Add properties here  
    

    /* Required method in a VisualForce controller */  
    
    public String getName() {
        return 'Customer';
    }
    public String companyName {get; set;}
    public Integer numEmployees {get; set;}
    public String streetAddress {get; set;}
    public String cityAddress {get; set;}
    public String stateAddress {get; set;}
    public String postalCodeAddress {get; set;}
    public String countryAddress {get; set;}
    public String department {get; set;}
    public String email {get; set;}
    public String phone {get; set;}
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String title {get; set;}  

    public void save() {
        Account a = new Account(
            Name = companyName,
            NumberOfEmployees = numEmployees,
            ShippingStreet = streetAddress,
            ShippingCity = cityAddress,
            ShippingState = stateAddress,
            ShippingPostalCode = postalCodeAddress,
            ShippingCountry = countryAddress);

        insert a;

        Contact c = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Account = a,
            Department = department,
            Email = email,
            Phone = phone,
            Title = title,
            MailingStreet = streetAddress,
            MailingCity = cityAddress,
            MailingState = stateAddress,
            MailingPostalCode = postalCodeAddress,
            MailingCountry = countryAddress);

        insert c;
    }

    public List<Account> getAccountList() {
        return [select name, numberofemployees from account];
    }

    /* Used for the Contact list at the end of the 
       VisualForce page 
    */
    public List<Contact> getContactList() {
        return [select name, title, department, email, phone 
                from contact];
    }
    }
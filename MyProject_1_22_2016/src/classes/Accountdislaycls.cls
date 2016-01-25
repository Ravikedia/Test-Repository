public  class Accountdislaycls {
  public List<Account> lstaccount{get;set;}
  public Accountdislaycls(){
    lstaccount=new List<Account>();
    //Retrive accounts records
    lstaccount=[select id,name,industry,type from Account];
   
  }
}
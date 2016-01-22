public  class Accountdislaycls {
  public List<Account> lstaccount{get;set;}
  public Accountdislaycls(){
    lstaccount=new List<Account>();
    lstaccount=[select id,name,industry,type from Account];///////
   
  }
}
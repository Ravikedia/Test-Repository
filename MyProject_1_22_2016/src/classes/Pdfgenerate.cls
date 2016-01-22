public class Pdfgenerate
{

    public transient blob file { get; set; }
    public String paramvalue{get; set;}
    public String base64data{get; set;}
    public String getFilename() {
        return null;
    }
  /*  public Pdfgenerate()
    {
        System.debug('File contents is'+file);
    }

    public String getFiletype() {
        return null;
    }*/


    public String getPdffile()
    {
        return null;
    }
     public PageReference pdfgenerate()
     {
       System.debug('File contents is'+file );
        paramvalue = EncodingUtil.base64Encode(file );
        base64data=paramvalue ;
       System.debug('File encoded is'+paramvalue );
       
        //PageReference pageRef =Page.Openpdfpage;
        // pageRef.setRedirect(false);
        // return pageref;
       
        return null;
     }
     public String getpassvalue()
     {
     string paramvalue = EncodingUtil.base64Encode(file );
     return paramvalue ;
     
     }


    

}
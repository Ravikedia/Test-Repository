public class PieChartRemoteController {

    
    public List<PieWedgeData> getPieData() {
        // Visualforce expressions can't pass parameters, so get from property
        return PieChartRemoteController.generatePieData();
    }
    
    @RemoteAction
    public static  List<PieWedgeData> getRemotePieData() {
        // Remoting calls can send parameters with the call
        return PieChartRemoteController.generatePieData();
    }

    // Private data "generator"
    private static  List<PieWedgeData> generatePieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<Opportunity> opp=[SELECT name, amount FROM Opportunity];
        for(Opportunity op : opp)
        {
          data.add(new PieWedgeData(op.name, op.amount));
        }
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public Decimal data { get; set; }

        public PieWedgeData(String name, Decimal data) {
            this.name = name;
            this.data = data;
        }
    }
}
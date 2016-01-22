// Controller

public class LatestTask 
{
public Task ta{get;set;}
    public String[] selectedWeekDays{get; set;}
    public List<SelectOption> weekDayList{get; set;}
    public String selectedMonthDay{get; set;}
    public List<SelectOption> monthDayList{get; set;}
    public String selectedDayOccurance{get; set;}
    public List<SelectOption> dayOccuranceList{get; set;}
    public String selectedWeekDay{get; set;}
    public String selectedTime{get; set;}
    public List<SelectOption> timeList{get; set;}
    public Date myDate {get;set;}
  
  public LatestTask(ApexPages.StandardController controller) 
  {         
    ta =new Task(); 
    
     if(selectedWeekDays == null)
        {
            selectedWeekDays = new String[]{};
            Integer weekDay = Math.mod(Date.newInstance(2000, 1, 1).daysBetween(System.now().date()) , 7);
            selectedWeekDays.add(String.valueOf((weekDay == 0) ? (weekDay + 1): weekDay));
        } 
        
        if(weekDayList == NULL)
        {
            weekDayList = new List<SelectOption>();
            weekDayList.add(new SelectOption('1', 'Sunday'));
            weekDayList.add(new SelectOption('2', 'Monday'));
            weekDayList.add(new SelectOption('3', 'Tuesday'));
            weekDayList.add(new SelectOption('4', 'Wednesday'));
            weekDayList.add(new SelectOption('5', 'Thursday'));
            weekDayList.add(new SelectOption('6', 'Friday'));
            weekDayList.add(new SelectOption('7', 'Saturday')); 
        }  
            //Assign month date to monthDayList
        if(monthDayList== NULL)
        {           
            monthDayList = new List<SelectOption>();
            
            for(Integer i = 1; i < 31; i++)
                monthDayList.add(new SelectOption(String.valueof(i),String.valueof(i)));
                monthDayList.add(new SelectOption('L','Last'));        
        } 
        if(dayOccuranceList == NULL)
        {
            dayOccuranceList = new List<SelectOption>();
            dayOccuranceList.add(new SelectOption('1', '1'));
            dayOccuranceList.add(new SelectOption('2', '2'));
            dayOccuranceList.add(new SelectOption('3', '3'));
            dayOccuranceList.add(new SelectOption('4', '4'));
            dayOccuranceList.add(new SelectOption('L', 'Last'));
        }
        
          //Assign time to timeList
        if(timeList == NULL)
        {
            timeList = new List<SelectOption>();
            timeList.add(new SelectOption('-1', '--None--'));
            timeList.add(new SelectOption('0', '12:00 AM'));
            timeList.add(new SelectOption('1', '1:00 AM'));
            timeList.add(new SelectOption('2', '2:00 AM'));
            timeList.add(new SelectOption('3', '3:00 AM'));
            timeList.add(new SelectOption('4', '4:00 AM'));                        
            timeList.add(new SelectOption('5', '5:00 AM'));                        
            timeList.add(new SelectOption('6', '6:00 AM'));                        
            timeList.add(new SelectOption('7', '7:00 AM'));                        
            timeList.add(new SelectOption('8', '8:00 AM'));                        
            timeList.add(new SelectOption('9', '9:00 AM'));                        
            timeList.add(new SelectOption('10', '10:00 AM'));                        
            timeList.add(new SelectOption('11', '11:00 AM'));                        
            timeList.add(new SelectOption('12', '12:00 PM'));                        
            timeList.add(new SelectOption('13', '1:00 PM'));                        
            timeList.add(new SelectOption('14', '2:00 PM'));                        
            timeList.add(new SelectOption('15', '3:00 PM'));                        
            timeList.add(new SelectOption('16', '4:00 PM'));                        
            timeList.add(new SelectOption('17', '5:00 PM'));                        
            timeList.add(new SelectOption('18', '6:00 PM'));                        
            timeList.add(new SelectOption('19', '7:00 PM'));                        
            timeList.add(new SelectOption('20', '8:00 PM'));                        
            timeList.add(new SelectOption('21', '9:00 PM'));                        
            timeList.add(new SelectOption('22', '10:00 PM'));                        
            timeList.add(new SelectOption('23', '11:00 PM'));                        
        }
      
            
  }   
   
    public List<FrequencyType> frequencyTypeList 
    {
        get
        {
            if(frequencyTypeList == null)
            {
                frequencyTypeList = new List<FrequencyType>();
                frequencyTypeList.add(new FrequencyType('Daily','Daily'));
                frequencyTypeList.add(new FrequencyType('Weekly','Weekly'));
                frequencyTypeList.add(new FrequencyType('Monthly', 'Monthly'));
                frequencyTypeList.add(new FrequencyType('Yearly', 'Yearly'));
            }
            return frequencyTypeList;
        }
        set;
    }
  public void Cancel() 
  { 
  }    
  public void SaveNewEvent()
  {           
  } 
  public void SaveNewTask() 
  {            
  }    
  public void Save() 
  {            
  } 
     public class FrequencyType
    {
        public string Name{get; set;}
        public string Value{get; set;}
        
        public FrequencyType(string name, string value)
        {
            this.Name = name;
            this.Value = value;
        }
    }
    /* End */
    
}
public class PMTask
{
    //List to store and display data on page
    public String[] selectedWeekDays{get; set;}
    public List<SelectOption> weekDayList{get; set;}
    public List<Selectoption> monthweekList{get; set;}
    public List<SelectOption> yearMonthList{get; set;}
    public List<SelectOption> reminderList{get; set;}
    public List<SelectOption> monthDayList{get; set;}
    public List<SelectOption> dayOccuranceList{get; set;}
    public List<SelectOption> timeList{get; set;}
    
    //String variable to store and display data on page
    public String selectedmonthWeek{get; set;}
    public String selectedreminder{get; set;}
    public String selectedMonthDay{get; set;}
    public String selectedTimevalue{get; set;}
    public String selectedDayOccurance{get; set;}
    public String selectedWeekDay{get; set;}
    public String selectedMonth{get; set;}
    public String selectedTime{get; set;}
    public String everydaysValue{get; set;}
    public String everyweekValue{get; set;}
    public String everymonthValue{get; set;}
    public String everymonthValue1{get; set;}
    public String selectedFrequencyType {get; set;}
    public String selectedMonthItem{get; set;}
    public String selectedDayOccuranceforyear{get; set;}
    public String selectedmonthWeekforyear{get; set;}
    public String selectedMonthDayforyear{get; set;}
    public String selectedMonthvalue{get; set;}
    public String selectedmonthWeekforyearvalue{get; set;}
    
    //Boolean variable to store and display checkbox on page
    public boolean sendNotificationCheckbox{get; set;}
    public boolean startdatecheckbox{get; set;}
    public Boolean showdates{get; set;}
    public Boolean rerecord{get;set;}
    public Date myDate {get;set;}
    
    //Object for data insert 
    public Task ta{get;set;}
    public Event condate{get;set;}//Change made here
    private User theUser;
    
    //Constructor start here 
    public PMTask(ApexPages.StandardController sc)
    {   
        rerecord = true;
        String recTypeIdStr = ApexPages.currentPage().getParameters().get('RecordType');
        //RecordType ch =[Select DeveloperName from RecordType where id =: recTypeIdStr][0];
      //  if(ch.get('DeveloperName')!='PM_Task')
           // rerecord= false;
        ta =new Task(IsReminderSet=true, RecurrenceStartDateOnly=Date.today()); 
       // if(! String.isBlank(recTypeIdStr))
            //ta.RecordTypeId = recTypeIdStr;
        everydaysValue='1';
        everyweekValue='1';
        everymonthValue='1';
        everymonthValue1='1';
        selectedFrequencyType='Daily';
        sendNotificationCheckbox=true;
        showdates=false;
        selectedMonthItem='RecursEveryWeekday';
        startdatecheckbox = false;
        condate = new Event(ActivityDate=Date.today());
        
        
        //store value in the list
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
            weekDayList.add(new SelectOption('4', 'Tuesday'));
            weekDayList.add(new SelectOption('8', 'Wednesday'));
            weekDayList.add(new SelectOption('16', 'Thursday'));
            weekDayList.add(new SelectOption('32', 'Friday'));
            weekDayList.add(new SelectOption('64', 'Saturday'));
            
        }
        
        if(monthweekList == NULL)
        {
            monthweekList = new List<SelectOption>();
            monthweekList.add(new SelectOption('1', 'Sunday'));
            monthweekList.add(new SelectOption('2', 'Monday'));
            monthweekList.add(new SelectOption('4', 'Tuesday'));
            monthweekList.add(new SelectOption('8', 'Wednesday'));
            monthweekList.add(new SelectOption('16', 'Thursday'));
            monthweekList.add(new SelectOption('32', 'Friday'));
            monthweekList.add(new SelectOption('64', 'Saturday')); 
        }  
        
        if(reminderList==null)
        {
            reminderList=new List<SelectOption>();
            reminderList.add(new SelectOption('0','On occurrence date'));
            reminderList.add(new SelectOption('1', '1 day before'));
            reminderList.add(new SelectOption('2', '2 day before'));
            reminderList.add(new SelectOption('3', '3 day before'));
            reminderList.add(new SelectOption('4', '4 day before'));
            reminderList.add(new SelectOption('5', '5 day before'));
            reminderList.add(new SelectOption('6', '6 day before'));
            reminderList.add(new SelectOption('7', '1 week before'));
            reminderList.add(new SelectOption('14', '2 weeks before')); 
        
        }
        if(yearMonthList == NULL)
        {
            yearMonthList = new List<SelectOption>();
            yearMonthList.add(new SelectOption('January', 'January'));
            yearMonthList.add(new SelectOption('February', 'February'));
            yearMonthList.add(new SelectOption('March', 'March'));
            yearMonthList.add(new SelectOption('april', 'april'));
            yearMonthList.add(new SelectOption('May', 'May'));
            yearMonthList.add(new SelectOption('June', 'June'));
            yearMonthList.add(new SelectOption('July', 'July'));
            yearMonthList.add(new SelectOption('August', 'August')); 
            yearMonthList.add(new SelectOption('September', 'September')); 
            yearMonthList.add(new SelectOption('october', 'october')); 
            yearMonthList.add(new SelectOption('November', 'November')); 
            yearMonthList.add(new SelectOption('December', 'December')); 
          
        }
        //Assign month date to monthDayList
        if(monthDayList== NULL)
        {           
            monthDayList = new List<SelectOption>();
            
            //for loop for insert value in monthDayList
            for(Integer i = 1; i <= 31; i++)
                monthDayList.add(new SelectOption(String.valueof(i),String.valueof(i)));
                //monthDayList.add(new SelectOption('L','Last'));        
        } 
        if(dayOccuranceList == NULL)
        {
            dayOccuranceList = new List<SelectOption>();
            dayOccuranceList.add(new SelectOption('first', '1'));
            dayOccuranceList.add(new SelectOption('second', '2'));
            dayOccuranceList.add(new SelectOption('third', '3'));
            dayOccuranceList.add(new SelectOption('fourth', '4'));
            dayOccuranceList.add(new SelectOption('last', 'Last'));
        }
        
        //Assign time to timeList
        if(timeList == NULL)
        {
            timeList = new List<SelectOption>();
            timeList.add(new SelectOption('00:00 AM', '12:00 AM'));
            timeList.add(new SelectOption('00:30 AM', '12:30 AM'));
            timeList.add(new SelectOption('01:00 AM', '1:00 AM'));
            timeList.add(new SelectOption('01:30 AM', '1:30 AM'));
            timeList.add(new SelectOption('02:00 AM', '2:00 AM'));
            timeList.add(new SelectOption('02:30 AM', '2:30 AM'));
            timeList.add(new SelectOption('03:00 AM', '3:00 AM'));
            timeList.add(new SelectOption('03:30 AM', '3:30 AM'));
            timeList.add(new SelectOption('04:00 AM', '4:00 AM')); 
            timeList.add(new SelectOption('04:30 AM', '4:30 AM'));                       
            timeList.add(new SelectOption('05:00 AM', '5:00 AM')); 
            timeList.add(new SelectOption('05:30 AM', '5:30 AM'));                       
            timeList.add(new SelectOption('06:00 AM', '6:00 AM'));
            timeList.add(new SelectOption('06:30 AM', '6:30 AM'));                        
            timeList.add(new SelectOption('07:00 AM', '7:00 AM'));  
            timeList.add(new SelectOption('07:30 AM', '7:30 AM'));                      
            timeList.add(new SelectOption('08:00 AM', '8:00 AM'));
            timeList.add(new SelectOption('08:30 AM', '8:30 AM'));                        
            timeList.add(new SelectOption('09:00 AM', '9:00 AM')); 
            timeList.add(new SelectOption('09:30 AM', '9:30 AM'));                       
            timeList.add(new SelectOption('10:00 AM', '10:00 AM'));
            timeList.add(new SelectOption('10:30 AM', '10:30 AM'));                        
            timeList.add(new SelectOption('11:00 AM', '11:00 AM'));
            timeList.add(new SelectOption('11:30 AM', '11:30 AM'));                        
            timeList.add(new SelectOption('12:00 PM', '12:00 PM')); 
            timeList.add(new SelectOption('12:30 PM', '12:30 PM'));                       
            timeList.add(new SelectOption('13:00 PM', '1:00 PM'));
            timeList.add(new SelectOption('13:30 PM', '1:30 PM'));                        
            timeList.add(new SelectOption('14:00 PM', '2:00 PM')); 
            timeList.add(new SelectOption('14:30 PM', '2:30 PM'));                       
            timeList.add(new SelectOption('15:00 PM', '3:00 PM'));   
            timeList.add(new SelectOption('15:30 PM', '3:30 PM'));                     
            timeList.add(new SelectOption('16:00 PM', '4:00 PM'));
            timeList.add(new SelectOption('16:30 PM', '4:30 PM'));                        
            timeList.add(new SelectOption('17:00 PM', '5:00 PM')); 
            timeList.add(new SelectOption('17:30 PM', '5:30 PM'));
            timeList.add(new SelectOption('18:00 PM', '6:00 PM'));  
            timeList.add(new SelectOption('18:30 PM', '6:30 PM'));                      
            timeList.add(new SelectOption('19:00 PM', '7:00 PM'));
            timeList.add(new SelectOption('19:30 PM', '7:30 PM'));                        
            timeList.add(new SelectOption('20:00 PM', '8:00 PM'));
            timeList.add(new SelectOption('20:30 PM', '8:30 PM'));                        
            timeList.add(new SelectOption('21:00 PM', '9:00 PM'));
            timeList.add(new SelectOption('21:30 PM', '9:30 PM'));                        
            timeList.add(new SelectOption('22:00 PM', '10:00 PM'));
            timeList.add(new SelectOption('22:30 PM', '10:30 PM'));                        
            timeList.add(new SelectOption('23:00 PM', '11:00 PM'));
            timeList.add(new SelectOption('23:30 PM', '11:30 PM'));                        
        }  
    }
    
    //method for cancel button
    public Pagereference Cancel() 
    { 
      PageReference pageref;
      pageref=new PageReference('/'+'home/home.jsp');
      return pageref;
   
    } 
    
    //method for make required start and end date
    public void checkdates()
    {
       if(showdates==false)
          showdates=true;
       else
          showdates=false;
    }
    
    //methd for save and new event
    public Pagereference SaveNewEvent()
    {           
        Save();
        PageReference pageref;
        String baseurl=URL.getSalesforceBaseUrl().toExternalForm();
        pageref=new PageReference(baseurl+'/00U/e');
        return pageref;
        
    } 
    
    //methd for save and new Task
    public Pagereference SaveNewTask() 
    {            
        Save();
        PageReference pageref;
        String baseurl=URL.getSalesforceBaseUrl().toExternalForm();
        pageref=new PageReference(baseurl+'/apex/PMTask');
        return pageref;
    } 
    
    //method for save button for data save   
    public Pagereference Save() 
    {               
       PageReference pageref;
       //check condition for recureence
       if(ta.IsRecurrence == false)
        {   
            
                 try
                 {  
                     //make dateTime for the RemainderDateTime
                     Datetime myDate= Datetime.newInstance(condate.ActivityDate, Time.newInstance(integer.valueof(selectedTime.split(' ')[0].split(':')[0]), integer.valueof(selectedTime.split(' ')[0].split(':')[1]), 0, 0));
                     
                     
                     //ta.TaskTemplate__c=template.Task_Template__c;
                     //check condition for reminder
                     if(ta.IsReminderSet == true)
                     {
                         ta.IsReminderSet=true;
                         ta.ReminderDateTime=myDate;
                     }
                     insert ta;
                     //check condition for send notification email
                     if(sendNotificationCheckbox == true)
                     {
                         //sendNotifiEmail();
                     }
                     pageref=new PageReference('/'+'home/home.jsp');
                 }
                 Catch(Exception e)
                 {
                     System.debug('Exception e       :::::::::::::::::::::::'+e);
                   //  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please selcet date in reminder section'));
                     return null;
                 }
                 
        }
        
       
        
         if(ta.IsRecurrence == true)
         {        
             
                   try
                   {
                        Integer da = Integer.valueof(selectedreminder);
                        date remindate = ta.RecurrenceStartDateOnly.adddays(-da);System.debug('@@@@@@@@'+remindate+'##########'+selectedTimevalue);
                        Datetime myDate= Datetime.newInstance(remindate, Time.newInstance(integer.valueof(selectedTimevalue.split(' ')[0].split(':')[0]), integer.valueof(selectedTimevalue.split(' ')[0].split(':')[1]), 0, 0));
                        if(ta.IsReminderSet == true )
                        {
                            ta.IsReminderSet = true;
                            ta.ReminderDateTime=myDate;
                        }
                   }
                   Catch(Exception e)
                   {
                    System.debug('Exception e ::::::::::'+e);
                   }
                    
          
                        
              if(selectedFrequencyType == 'Daily')
              {
                   if(selectedMonthItem == 'RecursDaily')
                   {
                        ta.RecurrenceInterval = Integer.valueof(everydaysValue);
                   }
                   if(selectedMonthItem == 'RecursEveryWeekday')
                   {   
                        ta.RecurrenceType = selectedMonthItem;
                        ta.RecurrenceDayOfWeekMask = 62;
                   }
              }
                
              if(selectedFrequencyType == 'Weekly')
              {
                    Integer weekmaskvalue=0;
                    for(String str : selectedWeekDays)
                    {
                        weekmaskvalue=weekmaskvalue+Integer.valueof(str);
                        
                    }
                    
                    ta.RecurrenceType = 'RecursWeekly';
                    ta.RecurrenceDayOfWeekMask =weekmaskvalue;
                    ta.RecurrenceInterval=Integer.valueof(everyweekValue);
            
               }
               
               if(selectedFrequencyType == 'Monthly')
               {
                
                    if(selectedMonthItem == 'RecursMonthly')
                    {
                       
                        ta.RecurrenceType = 'RecursMonthly';
                        ta.RecurrenceDayOfMonth  = Integer.valueof(selectedMonthDay);
                        ta.RecurrenceInterval = Integer.valueof(everymonthValue);
                    
                    }
                    
                    if(selectedMonthItem == 'RecursMonthlyNth')
                    { 
                        ta.RecurrenceType = 'RecursMonthlyNth';
                        ta.RecurrenceDayOfWeekMask  = Integer.valueof(selectedmonthWeek); // week day and their mask value
                        ta.RecurrenceInstance = selectedDayOccurance;                    // recurrence instance
                        ta.RecurrenceInterval = Integer.valueof(everymonthValue1);      // Recurrence interval between day occurence
                  
                    }   
               }
               
               if(selectedFrequencyType == 'Yearly')
               {
                      
                        if(selectedMonthItem == 'RecursYearly')
                        {  
                            ta.RecurrenceType = 'RecursYearly';
                            ta.RecurrenceDayOfMonth   =Integer.valueof(selectedMonthDayforyear);
                            ta.RecurrenceMonthOfYear = selectedMonth;
                        }
                        
                        if(selectedMonthItem == 'RecursYearlyNth')
                        { 
                            ta.RecurrenceType = 'RecursYearlyNth';
                            ta.RecurrenceDayOfWeekMask    = Integer.valueOf(selectedmonthWeekforyearvalue); // week day and their mask value
                            ta.RecurrenceInstance = selectedDayOccuranceforyear;  //picklist value possible value First, Second , Third, Fourth, last
                            ta.RecurrenceMonthOfYear = selectedMonthvalue; // picklist value for the selected month  
                        }
               }
               try
               {  
                  // ta.TaskTemplate__c=template.Task_Template__c;
                  // insert ta;
                   //check condition for send notification email
                   if(sendNotificationCheckbox == true)
                   {
                      // sendNotifiEmail();
                   }
                    
               }
               catch(Exception e)
               {
                   System.debug('Exception e :::::::::::::::'+e); 
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please selcet correct end date.'));
                   return null;
               }
                pageref=new PageReference('/'+'home/home.jsp');
             }
               return pageref;
   }

    //List for the frequency in the recurrence task
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
    
    
  
    /* Code Related to Cron Expression Generator END Here */
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
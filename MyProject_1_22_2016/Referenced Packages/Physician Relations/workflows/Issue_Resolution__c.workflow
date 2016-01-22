<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_Issue_Resolver</fullName>
        <ccEmails>ravikantkedia@gmail.com</ccEmails>
        <description>Email Alert to Issue Resolver</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public_Folder/Resolution_Email</template>
    </alerts>
    <rules>
        <fullName>Internal Resolver</fullName>
        <actions>
            <name>Email_Alert_to_Issue_Resolver</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(  Resolution_Person__c  ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

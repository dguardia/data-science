select
o.ID Opp_ID,
o.createddate Opp_CreatedDate,
o.InflowDate__c,
CloseDate,
w.FirstWinDate,
DATEDIFF(day, o.createddate, o.closedate) as daysfromcreate,
StageName,
o.AccountId,
o.Software_Amount__c,
o.[AcquisitionType__c],
h.LastUpdate,
h.LastForecastCategory,
h.LastStageName,
IIF(o.CloseDate>FirstWinDate,'No','Yes') NewBusinessAtClose,
iif(stagename = 'Closed/Won',1,0) WonOpp
,o.Software_Amount__c,
case when o.Amount_Maintenance_Renewal__c > 0 then 1 else 0 end as hasMtnRenewal
,o.No_Software_Amount__c
,o.NewOrExistingCustomer__c
,o.CreatorRole__c
,o.DealLedBy__c
,o.SalesProcess__c
,o.PartnerValueAdd__c
,o.SDNote__c
,o.New_Project_or_Add_on_Revenue__c
,o.Number_of_Servers_for_THIS_Opportunity__c
,o.OpportunityDescriptionComments__c
,a.RelationshipType_Text__c
,a.ReportingLevel0__c
,a.ReportingLevel1__c
,a.ReportingLevel2__c
,a.Industry
,a.Segment__c
,a.NumberOfEmployees
,a.AnnualRevenue
,u.Start_Date_at_CommVault__c
from datalake.Salesforce.Opportunity o
left join (
    select distinct accountid,  min(closedate) FirstWinDate
    from Datalake.Salesforce.Opportunity
    where StageName='Closed/Won' and Software_Amount__c>0
    group by accountid
) w on w.AccountId = o.AccountId
left join (Select
opportunityid,
CreatedDate  as LastUpdate,
ForecastCategory  as LastForecastCategory,
StageName as LastStageName
from (Select CreatedDate, opportunityid,
ForecastCategory,
StageName,
row_number() over(partition by OpportunityId order by CreatedDate desc) as rn
from datalake.Salesforce.OpportunityHistory
where stagename not like '%Clos%') as T
where rn = 1) h
on o.id=h.OpportunityId
inner join Datalake.Salesforce.Account a on a.id = o.AccountId
left join Datalake.Salesforce.Account r on r.id = o.Reseller_Partner_Account__c
left join datalake.Salesforce.[User] u on o.ownerid=u.id
where stagename like '%Closed%'
and left(Fiscal_Quarter_Deal_Closed__c,4) in ('2016','2017', '2018', '2019') AND
o.Software_Amount__c > 1000
select
COALESCE(a.AccountId, 'NULL') + '#lic#' + convert(varchar,a.Id) + '#lic#' + LastUpdateTime as contentid,
a.LastUpdateTime as LastUpdateTimesf_mrg,
a.Id as Id_sf_mrg,
a.AccountGlobalId as AccountGlobalId_sf_mrg,
a.Revenue as Revenue_sf_mrg,
a.Employees as Employees_sf_mrg,
a.Status as Status_sf_mrg,
a.Customer_Status as Customer_Status_sf_mrg,
a.Type as Type_sf_mrg,
a.LicenseAgreementType as LicenseAgreementType_sf_mrg,
a.SoldBy as SoldBy_sf_mrg,
a.Industry as Industry_sf_mrg,
a.DoNotSolicit as DoNotSolicit_sf_mrg,
a.Region as Region_sf_mrg,
a.Sales_Theater as Sales_Theater_sf_mrg,
a.OwnerName as OwnerName_sf_mrg,
a.OwnerEmail as OwnerEmail_sf_mrg,
a.OwnerManagerName as OwnerManagerName_sf_mrg,
a.OwnerManagerEmail as OwnerManagerEmail_sf_mrg,
a.Sales_Region as Sales_Region_sf_mrg,
a.SicCode as SicCode_sf_mrg,
a.AccountId as AccountId_sf_mrg,
a.Americas_Segment as Americas_Segment_sf_mrg,
a.FaxNumber as FaxNumber_sf_mrg,
a.IsWatched as IsWatched_sf_mrg,
a.MailingCity as MailingCity_sf_mrg,
a.MailingCountry as MailingCountry_sf_mrg,
a.MailingPostalCode as MailingPostalCode_sf_mrg,
a.MailingState as MailingState_sf_mrg,
a.MailingStreet as MailingStreet_sf_mrg,
a.MainPhone as MainPhone_sf_mrg,
a.Name as Name_sf_mrg,
a.Segment as Segment_sf_mrg,
a.ShippingCity as ShippingCity_sf_mrg,
a.ShippingCountry as ShippingCountry_sf_mrg,
a.ShippingPostalCode as ShippingPostalCode_sf_mrg,
a.ShippingState as ShippingState_sf_mrg,
a.ShippingStreet as ShippingStreet_sf_mrg,
a.SupportAlert as SupportAlert_sf_mrg,
a.WebSite as WebSite_sf_mrg,
a.Import_Source as Import_Source_sf_mrg,
a.Date_Became_New_Customer as Date_Became_New_Customer_sf_mrg,
a.Date_Became_Existing_Customer as Date_Became_Existing_Customer_sf_mrg,
a.AccountRecordTypeIdName as AccountRecordTypeIdName_sf_mrg,
a.UpgradedCommCellGlobalId as UpgradedCommCellGlobalId_sf_mrg,
a.UpgradedCommCellId as UpgradedCommCellId_sf_mrg,
a.RelationshipType as RelationshipType_sf_mrg,
a.IsCASP as IsCASP_sf_mrg
from LACCMAccount a
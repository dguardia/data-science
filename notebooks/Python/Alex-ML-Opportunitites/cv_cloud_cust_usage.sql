select 
RTRIM(SUBSTRING(convert(varchar(8), Convert( varbinary(6), CONVERT(INT,map.[CommCellID], 2), 2), 2), 4, 8)) ccid,
csinfo.MonthStart,csinfo.UsedDiskSpaceMB, csinfo.BackupSize, csinfo.ProtectedVMs
 from cf_SurveyCapacityLicensePeakUsage csinfo
 inner join cf_CommcellIdNameMap map
                                on csinfo.CommServUniqueId = map.id
where RTRIM(SUBSTRING(convert(varchar(8), Convert( varbinary(6), CONVERT(INT,map.[CommCellID], 2), 2), 2), 4, 8)) like 'A%'
                                or RTRIM(SUBSTRING(convert(varchar(8), Convert( varbinary(6), CONVERT(INT,map.[CommCellID], 2), 2), 2), 4, 8)) like 'F%' and
                                RTRIM(SUBSTRING(convert(varchar(8), Convert( varbinary(6), CONVERT(INT, map.commcellid, 2), 2), 2), 4, 8)) <> 'FFFFF'
 
 
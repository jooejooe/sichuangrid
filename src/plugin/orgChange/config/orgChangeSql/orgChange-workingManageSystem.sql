--迁移合并业务配置：日常办公
insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'fourLevelPlatformManagement', 1, 'FOURLEVELPLATFORM', 'ORGID', 'ORGINTERNALCODE', 1, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate, 'workingManageSystemHandler');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'workDiary', 1, 'WORKDIARYS', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate, '');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'myPeopleLogManagement', 1, 'PEOPLELOG', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate, '');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'sharingInformationManagement', 1, 'USERHASMYPROFILEPERMISSIONS', 'ORGID', '', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate, '');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'myProfileManagement', 1, 'MYPROFILES', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate, '');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'dailyDirectory', 1, 'DAILYYEARS', 'MAKEDORGID', 'MAKEDORGINTERNALCODE', 1, 0, 1, 1, '', '', '', 'select t1.id ||'',''||t2.id as RESULT from (select id,yearDate from #TABLENAME# where #ORGIDCOLUMN# = #OLDORGID#) t1,(select id,yearDate from #TABLENAME# where #ORGIDCOLUMN# = #NEWORGID#) t2 where #OLDORGID#!=#NEWORGID# and  t1.yearDate= t2.yearDate', 'admin', sysdate, '', sysdate, 'workingManageSystemHandler');

insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'myWorkingRecordManagement', 1, 'WORKINGRECORDS', 'ORGID', 'ORGINTERNALCODE', 0, 0, 2, 1, 'SELECT COUNT(*) FROM #TABLENAME# WHERE DAILYLOGTYPE is not null  and #ORGIDCOLUMN# = #OLDORGID#', '', 'UPDATE #TABLENAME# SET #ORGIDCOLUMN#=#NEWORGID#,#ORGCODECOLUMN#=#NEWORGCODE# WHERE DAILYLOGTYPE is not null  and  #ORGIDCOLUMN# = #OLDORGID#', '', 'admin', sysdate, '', sysdate, '');

--公文管理
insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, SPLIT, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_moduletable.nextval, 'dispatchDocumentsManagement', 1, null, 'DOCUMENTS', 'ORGID', null, null, 0, 0, 1, 1, null, null, null, null, 'admin', sysdate, null, sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, SPLIT, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_moduletable.nextval, 'receiveDocumentsManagement', 1, null, 'DOCUMENTSHASORG', 'ORGANIZATIONID', null, null, 0, 0, 1, 1, null, null, null, null, 'admin', sysdate, null, sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, SPLIT, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_moduletable.nextval, 'sendDocumentObjectsManagement', 1, null, 'MYDEPARTMENTGROPS', 'ORGID', null, null, 0, 0, 1, 1, null, 'select id dataId,#ORGIDCOLUMN# dataOrgId,'''' expansionData from #TABLENAME# where #ORGIDCOLUMN#= #OLDORGID# and #OLDORGID#!=#NEWORGID#', null, 'delete #tableName# t1 where orgId = #oldOrgId#   and exists (select *  from #tableName# t2  where t2.orgId = #newOrgId#  and t1.name= t2.name)  and #oldOrgId# <> #newOrgId#', 'admin', sysdate, null, sysdate);

commit;
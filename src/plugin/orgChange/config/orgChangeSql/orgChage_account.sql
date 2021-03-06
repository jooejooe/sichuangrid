/*组织机构迁移合并 三本台账相关脚本*/
insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'peopleAspirationListManagement', 1, '', 'ACCOUNTSTEPS_XICHANG', 'TARGETORGID', 'TARGETORGCODE', 0, 0, 4, 1, '', '', 'UPDATE #TABLENAME# SET TARGETORGID=#NEWORGID#,TARGETORGCODE=#NEWORGCODE# WHERE TARGETORGID = #OLDORGID# AND ISFINISH=0', '', 'admin', sysdate, '', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'peopleAspirationListManagement', 1, '', 'EVALUATEFEEDBACKS', 'ORGID', 'ORGINTERNALCODE', 0, 0, 3, 1, '', '', '', '', 'admin', sysdate, 'admin', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'steadyWorkManagement', 1, '', 'STEADYWORKS', 'OCCURORGID', 'OCCURORGINTERNALCODE', 0, 0, 2, 1, '', '', '', '', 'admin', sysdate, 'admin', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'steadyWorkManagement', 1, '', 'STEADYWORKS', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, 'admin', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'poorPeopleManagement', 1, '', 'POORPEOPLES', 'OCCURORGID', 'OCCURORGINTERNALCODE', 0, 0, 2, 1, '', '', '', '', 'admin', sysdate, 'admin',sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'poorPeopleManagement', 1, '', 'POORPEOPLES', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, 'admin', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'peopleAspirationListManagement', 1, '', 'PEOPLEASPIRATIONS', 'OCCURORGID', 'OCCURORGINTERNALCODE', 0, 0, 2, 1, '', '', '', '', 'admin', sysdate, '', sysdate);

insert into moduletable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'peopleAspirationListManagement', 1, '', 'PEOPLEASPIRATIONS', 'ORGID', 'ORGINTERNALCODE', 0, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate);

commit;
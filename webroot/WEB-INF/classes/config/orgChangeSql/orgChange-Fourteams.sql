--四支队伍
insert into moduleTable (ID, ENAME, ACTIVE, BEANNAME, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE)
values (s_MODULETABLE.NEXTVAL, 'teamStatusManagement', 1, 'fourteamHandler', 'FOURTEAMS', 'ORGID', 'ORGCODE', 1, 0, 1, 1, '', '', '', '', 'admin', sysdate, '', sysdate);

--四支队伍架结构图
insert into moduletable (ID, ENAME, ACTIVE, TABLENAME, ORGIDCOLUMN, ORGCODECOLUMN, EXECUTETYPE, ISMAINTABLE, EXECUTELEVEL, OPERATEMODE, COUNTSCRIPT, SELECTSCRIPT, UPDATESCRIPT, DELETESCRIPT, CREATEUSER, CREATEDATE, UPDATEUSER, UPDATEDATE, BEANNAME)
values (s_MODULETABLE.NEXTVAL, 'organizationChartManagement', 1, 'FOURTEAMSORG', 'ORGANIZATION', 'ORGINTERNALCODE', 0, 0, 1, 1, 'SELECT COUNT(*) FROM #TABLENAME# WHERE #ORGIDCOLUMN# = #OLDORGID#', 'SELECT ID DATAID , ''''  expansionData,#ORGIDCOLUMN# DATAORGID FROM #TABLENAME#  WHERE #ORGIDCOLUMN# = #OLDORGID#', 'UPDATE #TABLENAME# SET #ORGIDCOLUMN#=#NEWORGID#,#ORGCODECOLUMN#=#NEWORGCODE# WHERE #ORGIDCOLUMN# = #OLDORGID#', 'DELETE FROM #TABLENAME# WHERE #ORGIDCOLUMN# = #OLDORGID# AND #OLDORGID# <>  #NEWORGID#', 'admin', sysdate, 'admin', sysdate, '');

commit ;

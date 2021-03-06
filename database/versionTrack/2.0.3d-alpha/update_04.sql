-------创建任务表id自增序列
create sequence s_TASK
increment by 1 
start with 1
maxvalue 9999999999
minvalue 1 
cache 20;

-------创建策略表id自增序列
create sequence s_TASKPLOY
increment by 1
start with 1
maxvalue 9999999999
minvalue 1
cache 20;

-------策略表
CREATE TABLE TASKPLOY(
       ID                NUMBER(10)                NOT NULL,
       CNAME                VARCHAR2(100)                NOT NULL,
       ENAME                VARCHAR2(100)                NOT NULL,
       TYPE                INTEGER                NOT NULL,
       DESCRIPTION                VARCHAR2(100)                NOT NULL,
       CODE                VARCHAR2(500)                NOT NULL,
       constraint PK_TASKPLOY primary key (ID)
);
comment on table taskPloy is
'策略表';
comment on column taskPloy.id is
'ID';
comment on column taskPloy.cname is
'策略中文名称';
comment on column taskPloy.ename is
'策略英文名称';
comment on column taskPloy.type is
'策略类型';
comment on column taskPloy.DESCRIPTION is
'策略描述';
comment on column taskPloy.code is
'策略代码';

-------任务管理表
CREATE TABLE TASK(
       ID                NUMBER(10)                NOT NULL,
       NAME                VARCHAR2(100)                NOT NULL,
       TASKGROUP                VARCHAR2(100)                DEFAULT 'tqGroup',
       DESCRIPTION                VARCHAR2(100),
       PLOYID                NUMBER(10)                NOT NULL,
       CONFIG                VARCHAR2(100)             NOT NULL,
       CLOSED                SMALLINT DEFAULT 0,
       constraint PK_TASK primary key (ID)
);
comment on table task is
'任务表';
comment on column task.id is
'ID';
comment on column task.name is
'任务名称';
comment on column task.TASKGROUP is
'任务组';
comment on column task.DESCRIPTION is
'任务描述';
comment on column task.ployId is
'策略id';
comment on column task.closed is
'任务是否关闭';

-----job持久化字典项
------任务类型
insert into propertydomains values(s_propertyDomains.NEXTVAL ,'任务类型',0,'');

insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务类型'), 0, 1, '存储过程', 'ccgc', 'cunchuguocheng', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务类型'), 0, 2, '函数', 'hs', 'hanshu', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务类型'), 0, 3, 'sql语句', 'sqlyj', 'sqlyuju', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务类型'), 0, 4, 'java方法', 'javaff', 'javafangfa', 'admin',sysdate);

----任务频率
insert into propertydomains values(s_propertyDomains.NEXTVAL ,'任务频率',0,'');

insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 1, '每年', 'mn', 'meinian', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 2, '每月', 'my', 'meiyue', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 3, '每周', 'mt', 'meizhou', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 4, '每天', 'mt', 'meitian', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 5, '每时', 'ms', 'meishi', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 6, '每分', 'mf', 'meifen', 'admin',sysdate);
insert into propertydicts (ID, PROPERTYDOMAINID, INTERNALID, DISPLAYSEQ, DISPLAYNAME, SIMPLEPINYIN, FULLPINYIN, CREATEUSER, CREATEDATE)
values (s_propertyDicts.Nextval, (select id from propertydomains where domainname='任务频率'), 0, 7, '每秒', 'mm', 'meimiao', 'admin',sysdate);
------所有的job持久化配置
-----实有人口历史数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'实有人口历史数据job','automaticPopulationStatDispatch',(select id from propertydicts where displayname='java方法'),'实有人口历史数据job','automaticPopulationStatDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'automaticPopulationStatDispatch','automaticPopulationStatDispatch','automaticPopulationStatDispatch',(select id from taskploy where ename='automaticPopulationStatDispatch'),'0 10 0 1 * ?',1);
-----旧的单位场所历史数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'旧的单位场所历史数据job','baseInfoStatTypeDispatch',(select id from propertydicts where displayname='java方法'),'旧的单位场所历史数据job','baseInfoStatTypeDispatch.saveBaseInfoStatType');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'baseInfoStatTypeDispatch','baseInfoStatTypeDispatch','baseInfoStatTypeDispatch',(select id from taskploy where ename='baseInfoStatTypeDispatch'),'1 50 22 L * ?',1);
-----重点青少年到期提醒job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'重点青少年到期提醒job','idleYouthTowDispatch',(select id from propertydicts where displayname='java方法'),'重点青少年到期提醒job','idleYouthTowDispatch.emphasisIdleYouthJob');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'idleYouthTowDispatch','idleYouthTowDispatch','idleYouthTowDispatch',(select id from taskploy where ename='idleYouthTowDispatch'),'0 30 1 * * ?',1);
-----服务办事办理统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'服务办事办理统计job','issueDealStatDispatch',(select id from propertydicts where displayname='java方法'),'服务办事办理统计job','issueDealStatDispatch.addMonthOrgLoginStanals');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueDealStatDispatch','issueDealStatDispatch','issueDealStatDispatch',(select id from taskploy where ename='issueDealStatDispatch'),'0 20 1 1 * ?',1);
-----已办结事件分离job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'已办结事件分离job','issueExtractionDispatch',(select id from propertydicts where displayname='java方法'),'已办结事件分离job','issueExtractionDispatch.extractionIssues');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueExtractionDispatch','issueExtractionDispatch','issueExtractionDispatch',(select id from taskploy where ename='issueExtractionDispatch'),'0 15 1 3 * ?',1);
-----三本台账报表(县乡镇)job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'三本台账报表(县乡镇)job','accountReportDispatch',(select id from propertydicts where displayname='java方法'),'三本台账报表(县乡镇)job','accountReportDispatch.createAccountReportJobData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'accountReportDispatch','accountReportDispatch','accountReportDispatch',(select id from taskploy where ename='accountReportDispatch'),'0 17 1 21 * ?',1);
-------三本台账报表(社区)job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'三本台账报表(社区)job','accountReportVillageDispatch',(select id from propertydicts where displayname='java方法'),'三本台账报表(社区)job','accountReportVillageDispatch.createAccountReportJobData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'accountReportVillageDispatch','accountReportVillageDispatch','accountReportVillageDispatch',(select id from taskploy where ename='accountReportVillageDispatch'),'0 7 1 21 * ?',1);
----actualCompanyStatJobTrigger没有找到实现类
-----生成实口的领导视图历史月份job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'生成实口的领导视图历史月份job','actualPopulationLeaderViewSummaryCountDispatch',(select id from propertydicts where displayname='java方法'),'生成实口的领导视图历史月份job','actualPopulationLeaderViewSummaryCountDispatch.createActualPopulationLeaderViewSummaryData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'actualPopulationLeaderViewSummaryCountDispatch','actualPopulationLeaderViewSummaryCountDispatch','actualPopulationLeaderViewSummaryCountDispatch',(select id from taskploy where ename='actualPopulationLeaderViewSummaryCountDispatch'),'11 11 2 1 * ?',1);
----业务人员当前月领导视图数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'生成业务人员当前月领导视图数据job','attentionPeopleLeaderViewCountDispatch',(select id from propertydicts where displayname='java方法'),'生成业务人员当前月领导视图数据job','attentionPeopleLeaderViewCountDispatch.attentionPeopleLeaderViewMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'attentionPeopleLeaderViewCountDispatch','attentionPeopleLeaderViewCountDispatch','attentionPeopleLeaderViewCountDispatch',(select id from taskploy where ename='attentionPeopleLeaderViewCountDispatch'),'26 4 7,12,17 * * ?',1);
------事件超时自动督办job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'事件超时自动督办job','issueOvertimeHandlerDispatch',(select id from propertydicts where displayname='java方法'),'事件超时自动督办job','issueOvertimeHandlerDispatch.autoIsueSupervise');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueOvertimeHandlerDispatch','issueOvertimeHandlerDispatch','issueOvertimeHandlerDispatch',(select id from taskploy where ename='issueOvertimeHandlerDispatch'),'0 0 21 * * ?',1);
------业务人员、两新组织、房屋等历史数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'业务人员、两新组织、房屋等历史数据job','automaticAttentionPopulationStatDispatch',(select id from propertydicts where displayname='java方法'),'业务人员、两新组织、房屋等历史数据job','automaticAttentionPopulationStatDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'automaticAttentionPopulationStatDispatch','automaticAttentionPopulationStatDispatch','automaticAttentionPopulationStatDispatch',(select id from taskploy where ename='automaticAttentionPopulationStatDispatch'),'0 1 0 1 * ?',1);
-----户籍人员统计类型图数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'户籍人员统计类型图数据job','automaticHouseholdStaffPopulationStatDispatch',(select id from propertydicts where displayname='java方法'),'户籍人员统计类型图数据job','automaticHouseholdStaffPopulationStatDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'automaticHouseholdStaffPopulationStatDispatch','automaticHouseholdStaffPopulationStatDispatch','automaticHouseholdStaffPopulationStatDispatch',(select id from taskploy where ename='automaticHouseholdStaffPopulationStatDispatch'),'0 11 0 1 * ?',1);
----青少年自动统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'青少年自动统计类型图数据job','automaticYouthPopulationStatDispatch',(select id from propertydicts where displayname='java方法'),'青少年自动统计类型图数据job','automaticYouthPopulationStatDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'automaticYouthPopulationStatDispatch','automaticYouthPopulationStatDispatch','automaticYouthPopulationStatDispatch',(select id from taskploy where ename='automaticYouthPopulationStatDispatch'),'0 20 0 1 * ?',1);
-----基本信息统计报表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'基本信息统计报表job','basesituationStatementStatisticsDispatch',(select id from propertydicts where displayname='java方法'),'基本信息统计报表job','basesituationStatementStatisticsDispatch.addBasesituationStatementStatistics');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'basesituationStatementStatisticsDispatch','basesituationStatementStatisticsDispatch','basesituationStatementStatisticsDispatch',(select id from taskploy where ename='basesituationStatementStatisticsDispatch'),'4 51 3 1 * ?',1);
------楼宇历史数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'楼宇历史数据job','builddataDispatch',(select id from propertydicts where displayname='java方法'),'楼宇历史数据job','builddataDispatch.statisticBuilddata');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'builddataDispatch','builddataDispatch','builddataDispatch',(select id from taskploy where ename='builddataDispatch'),'0 0 22 1 * ? *',1);
----生成业务人员的领导视图历史月份job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'生成业务人员的领导视图历史月份job','bussinessPopulationLeaderViewSummaryCountDispatch',(select id from propertydicts where displayname='java方法'),'生成业务人员的领导视图历史月份job','bussinessPopulationLeaderViewSummaryCountDispatch.createBussinessPopulationLeaderViewSummaryData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'bussinessPopulationLeaderViewSummaryCountDispatch','bussinessPopulationLeaderViewSummaryCountDispatch','bussinessPopulationLeaderViewSummaryCountDispatch',(select id from taskploy where ename='bussinessPopulationLeaderViewSummaryCountDispatch'),'11 10 3 1 * ?',1);
------------------------------------------------------
----清除缓存表数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'清除缓存表数据job','cleanLeaderviewcacheDispatch',(select id from propertydicts where displayname='java方法'),'清除缓存表数据job','cleanLeaderviewcacheDispatch.cleanLeaderviewcache');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'cleanLeaderviewcacheDispatch','cleanLeaderviewcacheDispatch','cleanLeaderviewcacheDispatch',(select id from taskploy where ename='cleanLeaderviewcacheDispatch'),'35 0 0 ? * 7',1);
----单位场所研判分析统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'单位场所研判分析统计job','companyPlaceAnalyzStatisticsDispatch',(select id from propertydicts where displayname='java方法'),'单位场所研判分析统计job','companyPlaceAnalyzStatisticsDispatch.companyPlaceAnalyzStatistics');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'companyPlaceAnalyzStatisticsDispatch','companyPlaceAnalyzStatisticsDispatch','companyPlaceAnalyzStatisticsDispatch',(select id from taskploy where ename='companyPlaceAnalyzStatisticsDispatch'),'0 50 21 L * ?',1);
----单位场所领导视图当月数据统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'单位场所领导视图当月数据统计job','companyPlaceLeaderViewDispatch',(select id from propertydicts where displayname='java方法'),'单位场所领导视图当月数据统计job','companyPlaceLeaderViewDispatch.companyPlaceLeaderView');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'companyPlaceLeaderViewDispatch','companyPlaceLeaderViewDispatch','companyPlaceLeaderViewDispatch',(select id from taskploy where ename='companyPlaceLeaderViewDispatch'),'0 41 7,12 * * ?',1);
----单位场所领导视图历史月份job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'单位场所领导视图历史月份job','companyplaceLeaderViewSummaryCountDispatch',(select id from propertydicts where displayname='java方法'),'单位场所领导视图历史月份job','companyplaceLeaderViewSummaryCountDispatch.companyPlaceLeaderView');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'companyplaceLeaderViewSummaryCountDispatch','companyplaceLeaderViewSummaryCountDispatch','companyplaceLeaderViewSummaryCountDispatch',(select id from taskploy where ename='companyplaceLeaderViewSummaryCountDispatch'),'11 11 1 1 * ?',1);
-------dataManageDBJob没有找到配置的地方
----对数据库新导入数据进行操作的job类
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'对数据库新导入数据进行操作的job类','dataManageDBDispatch',(select id from propertydicts where displayname='java方法'),'对数据库新导入数据进行操作的job类','dataManageDBDispatch.disposeDB');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'dataManageDBDispatch','dataManageDBDispatch','dataManageDBDispatch',(select id from taskploy where ename='dataManageDBDispatch'),'0 21 23 * * ?',0);

----党委部门数据统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'党委部门数据统计job','departmentPartyStatisticsDispatch',(select id from propertydicts where displayname='java方法'),'党委部门数据统计job','departmentPartyStatisticsDispatch.addDepartmentPartyHistory');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'departmentPartyStatisticsDispatch','departmentPartyStatisticsDispatch','departmentPartyStatisticsDispatch',(select id from taskploy where ename='departmentPartyStatisticsDispatch'),'0 50 22 L * ?',1);
----删除过期的导入日志job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'删除过期的导入日志job','excelImportLogCleanDispatch',(select id from propertydicts where displayname='java方法'),'删除过期的导入日志job','excelImportLogCleanDispatch.excelImportLogClean');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'excelImportLogCleanDispatch','excelImportLogCleanDispatch','excelImportLogCleanDispatch',(select id from taskploy where ename='excelImportLogCleanDispatch'),'0 23 0 1,11,21 * ?',1);
----流口转老年人job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'流口转老年人job','floatingPopulationDispatch',(select id from propertydicts where displayname='java方法'),'流口转老年人job','floatingPopulationDispatch.updateFloatingPopulationLogOut');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'floatingPopulationDispatch','floatingPopulationDispatch','floatingPopulationDispatch',(select id from taskploy where ename='floatingPopulationDispatch'),'0 1 1 * * ?',1);
----生成房屋的领导视图历史月份job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'生成房屋的领导视图历史月份job','houseLeaderViewSummaryCountDispatch',(select id from propertydicts where displayname='java方法'),'生成房屋的领导视图历史月份job','houseLeaderViewSummaryCountDispatch.createHouseLeaderViewSummaryData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'houseLeaderViewSummaryCountDispatch','houseLeaderViewSummaryCountDispatch','houseLeaderViewSummaryCountDispatch',(select id from taskploy where ename='houseLeaderViewSummaryCountDispatch'),'11 8 3 1 * ?',1);
----户籍转老年人job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'户籍转老年人job','householdStaffDispatch',(select id from propertydicts where displayname='java方法'),'户籍转老年人job','householdStaffDispatch.updateHouseholdStaffLogOut');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'householdStaffDispatch','householdStaffDispatch','householdStaffDispatch',(select id from taskploy where ename='householdStaffDispatch'),'0 2 1 * * ?',1);
-----删除互动交流收、发件箱过期消息job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'删除互动交流收、发件箱过期消息job','interactCommunicationMessageCleanDispatch',(select id from propertydicts where displayname='java方法'),'删除互动交流收、发件箱过期消息job','interactCommunicationMessageCleanDispatch.cleanInteractCommunicationMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'interactCommunicationMessageCleanDispatch','interactCommunicationMessageCleanDispatch','interactCommunicationMessageCleanDispatch',(select id from taskploy where ename='interactCommunicationMessageCleanDispatch'),'0 19 0 * * ?',1);
-----事件按照大类小类维度统计数量Job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'事件按照大类小类维度统计数量Job','issueAnalysisChartDispatch',(select id from propertydicts where displayname='java方法'),'事件按照大类小类维度统计数量Job','issueAnalysisChartDispatch.createIssueAnalysisChartData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueAnalysisChartDispatch','issueAnalysisChartDispatch','issueAnalysisChartDispatch',(select id from taskploy where ename='issueAnalysisChartDispatch'),'0 15 22 L * ?',1);
----手机事件研判分析job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'手机事件研判分析job','issueAnalysisToMobileDispatch',(select id from propertydicts where displayname='java方法'),'手机事件研判分析job','issueAnalysisToMobileDispatch.createIssueAnalysisToMobileData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueAnalysisToMobileDispatch','issueAnalysisToMobileDispatch','issueAnalysisToMobileDispatch',(select id from taskploy where ename='issueAnalysisToMobileDispatch'),'23 43 21 L * ?',1);
-----事件省级列表缓存job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'事件省级列表缓存job','issueCacheDispatch',(select id from propertydicts where displayname='java方法'),'事件省级列表缓存job','issueCacheDispatch.handleIssueCache');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueCacheDispatch','issueCacheDispatch','issueCacheDispatch',(select id from taskploy where ename='issueCacheDispatch'),'0 0 */4 * * ?',1);
-----扫描青羊事件对接表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'扫描青羊事件对接表job','issueJointTempDataSyncDispatch',(select id from propertydicts where displayname='java方法'),'扫描青羊事件对接表job','issueJointTempDataSyncDispatch.syncIssueJointTempData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueJointTempDataSyncDispatch','issueJointTempDataSyncDispatch','issueJointTempDataSyncDispatch',(select id from taskploy where ename='issueJointTempDataSyncDispatch'),'11 23 3 * * ?',1);
----事件统计列表数据job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'事件统计列表数据job','issueReportStatDispatch',(select id from propertydicts where displayname='java方法'),'事件统计列表数据job','issueReportStatDispatch.statIssueReport');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'issueReportStatDispatch','issueReportStatDispatch','issueReportStatDispatch',(select id from taskploy where ename='issueReportStatDispatch'),'0 16 22 L * ?',1);
------人口领导视图当前月job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'人口领导视图当前月job','leaderViewCountDispatch',(select id from propertydicts where displayname='java方法'),'人口领导视图当前月job','leaderViewCountDispatch.leaderViewHourMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'leaderViewCountDispatch','leaderViewCountDispatch','leaderViewCountDispatch',(select id from taskploy where ename='leaderViewCountDispatch'),'5 2 6,8,12,17 * * ?',1);
----房屋领导视图当前月job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'房屋领导视图当前月job','leaderViewHouseCountDispatch',(select id from propertydicts where displayname='java方法'),'房屋领导视图当前月job','leaderViewHouseCountDispatch.leaderViewHouseInfoMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'leaderViewHouseCountDispatch','leaderViewHouseCountDispatch','leaderViewHouseCountDispatch',(select id from taskploy where ename='leaderViewHouseCountDispatch'),'10 31 6,8,12,17 * * ?',1);
----青少年领导视图当前月job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'青少年领导视图当前月job','leaderYouthsViewCountDispatch',(select id from propertydicts where displayname='java方法'),'青少年领导视图当前月job','leaderYouthsViewCountDispatch.leaderViewHourMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'leaderYouthsViewCountDispatch','leaderYouthsViewCountDispatch','leaderYouthsViewCountDispatch',(select id from taskploy where ename='leaderYouthsViewCountDispatch'),'45 33 7,12 * * ?',1);
----用户登录情况月统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'用户登录情况月统计job','loginManageDispatch',(select id from propertydicts where displayname='java方法'),'用户登录情况月统计job','loginManageDispatch.addMonthLoginManageJob');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'loginManageDispatch','loginManageDispatch','loginManageDispatch',(select id from taskploy where ename='loginManageDispatch'),'59 59 21 L * ?',1);
-----两新组织统计job,可以不启用
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'两新组织统计job','newEconomicDispatch',(select id from propertydicts where displayname='java方法'),'两新组织统计job','newEconomicDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'newEconomicDispatch','newEconomicDispatch','newEconomicDispatch',(select id from taskploy where ename='newEconomicDispatch'),'0 52 15 12 * ?',0);
-----育龄妇女自动注销job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'育龄妇女自动注销job','nurturesWomenDispatch',(select id from propertydicts where displayname='java方法'),'育龄妇女自动注销job','nurturesWomenDispatch.nurturesWomenLogout');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'nurturesWomenDispatch','nurturesWomenDispatch','nurturesWomenDispatch',(select id from taskploy where ename='nurturesWomenDispatch'),'0 5 21 * * ?',1);
----登录统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'登录统计job','orgLoginStanalsDispatch',(select id from propertydicts where displayname='java方法'),'登录统计job','orgLoginStanalsDispatch.addMonthOrgLoginStanals');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'orgLoginStanalsDispatch','orgLoginStanalsDispatch','orgLoginStanalsDispatch',(select id from taskploy where ename='orgLoginStanalsDispatch'),'1 3 20 * * ?',1);
----组织机构数据统计job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'组织机构数据统计job','organizationAnalyzingDispatch',(select id from propertydicts where displayname='java方法'),'组织机构数据统计job','organizationAnalyzingDispatch.addOrganizationHistory');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'organizationAnalyzingDispatch','organizationAnalyzingDispatch','organizationAnalyzingDispatch',(select id from taskploy where ename='organizationAnalyzingDispatch'),'0 40 22 L * ?',1);
-----刑释人员自动取消关注job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'刑释人员自动取消关注job','positiveInfoNewDispatch',(select id from propertydicts where displayname='java方法'),'刑释人员自动取消关注job','positiveInfoNewDispatch.emphasisPositiveInfoJob');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'positiveInfoNewDispatch','positiveInfoNewDispatch','positiveInfoNewDispatch',(select id from taskploy where ename='positiveInfoNewDispatch'),'0 30 0 * * ?',1);
-----社区矫正人员-矫正日到期job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'社区矫正人员-矫正日到期job','rectificativePersonDispatch',(select id from propertydicts where displayname='java方法'),'社区矫正人员-矫正日到期job','rectificativePersonDispatch.emphasisRectificativePersonJob');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'rectificativePersonDispatch','rectificativePersonDispatch','rectificativePersonDispatch',(select id from taskploy where ename='rectificativePersonDispatch'),'0 0 1 * * ?',1);
-----session超时job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'session超时job','sessionTimeOutDispatch',(select id from propertydicts where displayname='java方法'),'session超时job','sessionTimeOutDispatch.deleteTimeOutSessions');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'sessionTimeOutDispatch','sessionTimeOutDispatch','sessionTimeOutDispatch',(select id from taskploy where ename='sessionTimeOutDispatch'),'0 */10 * * * ?',1);
-----收信箱月末分表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'收信箱月末分表job','smsReceivedboxsDispatch',(select id from propertydicts where displayname='java方法'),'收信箱月末分表job','smsReceivedboxsDispatch.executeRec');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'smsReceivedboxsDispatch','smsReceivedboxsDispatch','smsReceivedboxsDispatch',(select id from taskploy where ename='smsReceivedboxsDispatch'),'0 0 1 1 * ?',1);
-----发信箱月末分表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'发信箱月末分表job','smsSendBoxsDispatch',(select id from propertydicts where displayname='java方法'),'发信箱月末分表job','smsSendBoxsDispatch.executeSend');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'smsSendBoxsDispatch','smsSendBoxsDispatch','smsSendBoxsDispatch',(select id from taskploy where ename='smsSendBoxsDispatch'),'0 0 2 1 * ?',1);
----事件处理成绩表综合指标job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'事件处理成绩表综合指标job','statRegradeDispatch',(select id from propertydicts where displayname='java方法'),'事件处理成绩表综合指标job','statRegradeDispatch.statRegradedPoints');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'statRegradeDispatch','statRegradeDispatch','statRegradeDispatch',(select id from taskploy where ename='statRegradeDispatch'),'0 44 23 L * ?',1);
----三本台账时限考核成绩job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'三本台账时限考核成绩job','statisticsAccountTimeoutsDispatch',(select id from propertydicts where displayname='java方法'),'三本台账时限考核成绩job','statisticsAccountTimeoutsDispatch.createStatisticsAccountTimeoutData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'statisticsAccountTimeoutsDispatch','statisticsAccountTimeoutsDispatch','statisticsAccountTimeoutsDispatch',(select id from taskploy where ename='statisticsAccountTimeoutsDispatch'),'0 10 0 21 * ?',1);
-----同步issue的当前处理状态到对接临时数据表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'同步issue的当前处理状态到对接临时数据表job','syncIssueStatusToIssueJointTempDataDispatch',(select id from propertydicts where displayname='java方法'),'同步issue的当前处理状态到对接临时数据表job','syncIssueStatusToIssueJointTempDataDispatch.syncIssueStatusToIssueJointTempData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'syncIssueStatusToIssueJointTempDataDispatch','syncIssueStatusToIssueJointTempDataDispatch','syncIssueStatusToIssueJointTempDataDispatch',(select id from taskploy where ename='syncIssueStatusToIssueJointTempDataDispatch'),'22 23 4,12,17 * * ?',1);
-----同步户籍地job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'同步户籍地job','syncPermanentAddressDispatch',(select id from propertydicts where displayname='java方法'),'同步户籍地job','syncPermanentAddressDispatch.syncPermanentAddress');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'syncPermanentAddressDispatch','syncPermanentAddressDispatch','syncPermanentAddressDispatch',(select id from taskploy where ename='syncPermanentAddressDispatch'),'0 0 23 * * ?',1);
----创建systemlog分表job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'创建systemlog分表job','systemLogsTableCreateDispatch',(select id from propertydicts where displayname='java方法'),'创建systemlog分表job','systemLogsTableCreateDispatch.createSystemLogTable');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'systemLogsTableCreateDispatch','systemLogsTableCreateDispatch','systemLogsTableCreateDispatch',(select id from taskploy where ename='systemLogsTableCreateDispatch'),'0 21 23 25,28 * ?',1);
------testJob没有找到配置的地方

----网格化服务管理信息系统使用情况job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'网格化服务管理信息系统使用情况job','usedInfoEverDayCountDispatch',(select id from propertydicts where displayname='java方法'),'网格化服务管理信息系统使用情况job','usedInfoEverDayCountDispatch.createUsedInfoEverDayCountCache');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'usedInfoEverDayCountDispatch','usedInfoEverDayCountDispatch','usedInfoEverDayCountDispatch',(select id from taskploy where ename='usedInfoEverDayCountDispatch'),'11 3 3 * * ?',1);
-----研判分析用户激活率job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'研判分析用户激活率job','userActivateReportDispatch',(select id from propertydicts where displayname='java方法'),'研判分析用户激活率job','userActivateReportDispatch.createUserActivateReportData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'userActivateReportDispatch','userActivateReportDispatch','userActivateReportDispatch',(select id from taskploy where ename='userActivateReportDispatch'),'23 44 22 L * ?',1);
----台帐目录job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'台帐目录job','whetherAutoStartDailyYearDispatch',(select id from propertydicts where displayname='java方法'),'台帐目录job','whetherAutoStartDailyYearDispatch.dailyYearJob');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'whetherAutoStartDailyYearDispatch','whetherAutoStartDailyYearDispatch','whetherAutoStartDailyYearDispatch',(select id from taskploy where ename='whetherAutoStartDailyYearDispatch'),'0 08 00 * * ?',1);
----青少年类型分类job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'青少年类型分类job','youthStatistDispatch',(select id from propertydicts where displayname='java方法'),'青少年类型分类job','youthStatistDispatch.statisticsMonthMessage');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'youthStatistDispatch','youthStatistDispatch','youthStatistDispatch',(select id from taskploy where ename='youthStatistDispatch'),'0 45 1 1 * ?',1);
----生成青少年的领导视图历史月份job
insert into taskploy(id,cname,ename,type,description,code) values(s_TASKPLOY.nextval,'生成青少年的领导视图历史月份job','youthsLeaderViewSummaryCountDispatch',(select id from propertydicts where displayname='java方法'),'生成青少年的领导视图历史月份job','youthsLeaderViewSummaryCountDispatch.createYouthsLeaderViewSummaryData');
insert into task(id,name,taskgroup,description,ployId,config,closed) values(s_TASK.nextval,'youthsLeaderViewSummaryCountDispatch','youthsLeaderViewSummaryCountDispatch','youthsLeaderViewSummaryCountDispatch',(select id from taskploy where ename='youthsLeaderViewSummaryCountDispatch'),'11 11 3 1 * ?',1);

--job持久化脚本
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '任务管理', 'taskManagement', 1, '系统高级管理', 1, (select id from permissions where ename='advancedSystemManagement'), '', '', '', 18, '');

insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '策略列表', 'taskPloyListManagement', 1, '任务管理', 1, (select id from permissions where ename='taskManagement'), '', '/hotModuel/task/taskPloyList.jsp', '', 0, '');

insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '搜索', 'searchTaskPloy', 0, '策略列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 0, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '新增', 'addTaskPloy', 0, '策略列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 1, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '修改', 'editTaskPloy', 0, '策略列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 2, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '批量删除', 'deleteTaskPloy', 0, '策略列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 3, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '刷新', 'refreshTaskPloy', 0, '策略列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 4, '');

insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '任务列表', 'taskListManagement', 1, '任务管理', 1, (select id from permissions where ename='taskManagement'), '', '/hotModuel/task/taskList.jsp', '', 1, '');

insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '搜索', 'searchTask', 0, '任务列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 0, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '新增', 'addTask', 0, '任务列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 1, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '修改', 'editTask', 0, '任务列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 2, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '批量删除', 'deleteTask', 0, '任务列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 3, '');
insert into PERMISSIONS (ID, CNAME, ENAME, PERMISSIONTYPE, MODULENAME, ENABLE, PARENTID, DESCRIPTION, NORMALURL, LEADERURL, INDEXID, GRIDURL)
values (s_permissions.nextval, '刷新', 'refreshTask', 0, '任务列表', 1, (select id from permissions where ename='taskPloyListManagement'), '', '', '', 4, '');

commit;
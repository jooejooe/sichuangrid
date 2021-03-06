<#assign pop=JspTaglibs["/WEB-INF/taglib/pop-taglib.tld"]>
<#assign s=JspTaglibs["/WEB-INF/taglib/struts-tags.tld"]>
<@s.include value="/includes/baseInclude.jsp"/>

<div id="main" class="main">
	<div class="mCrumbs" id="mCrumbs">当前位置：研判分析 > 人口信息 > <a href="javascript:;">户籍人口</a></div>
	<div id="mainBody" class="mainBody">
		<div class="modBox">
		    <div class="mHead">
		        <div class="switchViewMode">
		           <#-- <a class="icon" href="javascript:;"><span class="icon_main_export"></span>导出</a>
		            <a class="icon" href="javascript:;"><span class="icon_main_print"></span>打印</a>-->
		        </div>
		       <strong class="mHeadTit orgLevel" id="orgLevel">
                	<span id="orgName"></span>
					<span class="showDown"></span>
				</strong>
		       <select id="year"  style="height:20px;width:85px;background-color:white;font-size:15px;" class="titleSize">
				</select>
				<span class="titleSize">年</span>
				<select id="month"  style="height:20px;width:85px;background-color:white;font-size:15px;" class="titleSize">
				</select>
				<span class="titleSize">月</span>
				<a id="search" href="javascript:void(0)"><input  type="button"  style="height:25px;width:55px;font-size:15px;" value="查询"/></a>
		    </div>
		    <div class="mCont">
		        <div class="mContIntro"></div>

		        <div class="modBox subModBox trendAnalysis">
		            <div class="mHead">
		                <div class="switchViewMode" id="switchContrastConditions">
		                    <label><input checked="checked" type="radio" name="dataComparison" value="hb"/>环比</label>
		                    <label><input type="radio" name="dataComparison" value="tb"/>同比</label>
		                </div>
		                <strong class="mHeadTit">户籍人口趋势分析</strong>
		                <span class="currentTime"></span>
		            </div>
		            <div class="mCont">
                        <a href="javascript:;" class="goBack" id="goBack">
	                        <img src="${resource_path }/resource/judgmentAnalysis/img/icon_charts.png" alt=""/></a>
		                <div id="populationTrendAnalysis" style="height: 310px"></div>
		                <div id="gridPopulationTrendAnalysis" style="height: 310px;margin: 0 auto;"></div>
		            </div>
		        </div>
		
		        <div class="modBox subModBox">
		            <div class="mHead">
		                <div class="switchViewMode" id="switchDetailedAnalysis">
		                    <label><input type="radio" name="peopleType" value="sex" checked="checked" />性别</label>
		                    <label><input type="radio" name="peopleType" value="age"/>年龄</label>
		                    <label><input type="radio" name="peopleType" value="edu"/>文化程度</label>
		                    <label><input type="radio" name="peopleType" value="mar" />婚姻状况</label>
		                </div>
		                <strong class="mHeadTit">户籍人口细化分析</strong>
		                <span class="currentTime"></span>
		            </div>
		            <div class="mCont">
		                <div class="subModTips">
		                    <p>*温馨说明：该户籍人口数据细化分析是以户籍人口总数的性别、年龄、文化程度、婚姻状况的比例为基准而展开的联动变化。</p>
		                    <p>【例如：你选中第一个玫瑰图表中的女性区域，则其他的柱状图就会显示当前及下辖区域，女性中年龄、文化程度、婚姻状况的数据分布情况】</p>
		                </div>
		
		                <div class="chartsPiePart" id="chartsPiePart">
		                </div>
		                <div class="chartsBarPart cf" id="chartsBarPart">
	                        <div class="modBox subModBox chartsBarItem"></div>
                            <div class="modBox subModBox chartsBarItem">
                                <div class="mHead"><strong class="mHeadTit">性别</strong></div>
                                <div class="mCont">
                                    <div class="chartsBarItem" id="chartsBarGender"></div>
                                </div>
                            </div>
                            <div class="modBox subModBox chartsBarItem">
                                <div class="mHead"><strong class="mHeadTit">年龄</strong></div>
                                <div class="mCont">
                                    <div class="chartsBarItem" id="chartsBarAge"></div>
                                </div>
                            </div>
                            <div class="modBox subModBox chartsBarItem">
                                <div class="mHead"><strong class="mHeadTit">文化程度</strong></div>
                                <div class="mCont">
                                    <div class="chartsBarItem" id="chartsBarDiploma"></div>
                                </div>
                            </div>
                            <div class="modBox subModBox chartsBarItem">
                                <div class="mHead"><strong class="mHeadTit">婚姻状况</strong></div>
                                <div class="mCont">
                                    <div class="chartsBarItem" id="chartsBarMarriage"></div>
                                </div>
                            </div>

		                </div>
		
		            </div>
		        </div>
		
		    </div>
		</div>
	</div>
	<!-- end mainBody -->
</div>
<script src="${resource_path }/resource/judgmentAnalysis/js/analysisReport.js"></script>

<script type="text/javascript">





</script>
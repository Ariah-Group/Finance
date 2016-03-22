<%--
 Copyright 2005 The Kuali Foundation
 
 Licensed under the Educational Community License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.opensource.org/licenses/ecl2.php
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>
<%@ include file="/jsp/sys/kfsTldHeader.jsp"%>
<%@ attribute name="channelTitle" required="true" %>
<%@ attribute name="channelUrl" required="true" %>
<%@ attribute name="selectedTab" required="true" %>
<%-- JSTLConstants magic doesn't work for nested class KRADConstants.DetailTypes, hence the following uglyness: --%>
<c:set var="backdoorEnabled" value="<%=org.kuali.rice.coreservice.framework.CoreFrameworkServiceLocator.getParameterService().getParameterValueAsBoolean(org.kuali.rice.kew.api.KewApiConstants.KEW_NAMESPACE, org.kuali.rice.krad.util.KRADConstants.DetailTypes.BACKDOOR_DETAIL_TYPE, org.kuali.rice.kew.api.KewApiConstants.SHOW_BACK_DOOR_LOGIN_IND)%>"/>
<c:if test="${backdoorEnabled}">
    <c:choose> 
        <c:when test="${empty UserSession.loggedInUserPrincipalName}" > 
            <c:set var="backdoorIdUrl" value=""/> 			
        </c:when> 
        <c:otherwise> 			
            <c:choose>
                <c:when test="${UserSession.backdoorInUse}" >
                    <c:set var="backdoorIdUrl" value="backdoorId=${UserSession.principalName}"/> 					
                </c:when>
                <c:otherwise>
                    <c:set var="backdoorIdUrl" value="backdoorId=${UserSession.loggedInUserPrincipalName}"/>
                </c:otherwise>
            </c:choose>				 			
        </c:otherwise> 
    </c:choose>
</c:if>
<div id="mod_divHeader">
    <div class="mod_container" style="min-height: 45px;">
        <div id="mod_logoheader">
            <img src="static/images/logo.png" height="70" alt="Ariah Finance"/>
        </div>   
        <div id="mod_mainnavmenu">
            <ul class="mod_navigation navbar-right">
                <li><a href="portal.do?selectedTab=main">Main Menu</a></li>
                <li><a href="portal.do?selectedTab=maintenance">Maintenance</a></li>
                <li><a href="portal.do?selectedTab=administration">Administration</a></li>
            </ul>
        </div>       
    </div>
    <div class="toolbarbackground">
        <div class="mod_container" style="position: relative; clear:both;">
            <div class="mod_navbarbottom">
                <ul>
                    <li>&nbsp;${ConfigProperties.version}&nbsp;</li>
                    <li><portal:portalLink displayTitle="false" title='Search' url='${ConfigProperties.workflow.documentsearch.base.url}'>Search</portal:portalLink></li>
                    <li><portal:portalLink displayTitle="false" title='Action List' url='${ConfigProperties.kew.url}/ActionList.do'>Action List</portal:portalLink></li>
                    <li><a href="portal.do?selectedTab=support" >Help & Support</a></li>
                    <li><c:choose> <c:when test="${empty UserSession.loggedInUserPrincipalName}">&nbsp;You are not logged in.&nbsp;</c:when>
                            <c:otherwise>&nbsp;Logged in User:&nbsp;${UserSession.loggedInUserPrincipalName}&nbsp;<c:if test="${UserSession.backdoorInUse}">Impersonating User:&nbsp;${UserSession.principalName}&nbsp;</c:if></c:otherwise></c:choose>
                    </li>
                    <li><c:choose> 
                        <c:when test="${empty UserSession.loggedInUserPrincipalName}" > 
                        </c:when> 
                        <c:otherwise> 
                            <c:if test="${backdoorEnabled}">
                                <html:form action="/backdoorlogin.do" method="post" style="margin:0; display:inline">
                                    <input name="backdoorId" type="text" class="searchbox" size="10" title="Enter your backdoor ID here.">
                                    <input name="imageField" type="submit" value="Login" class="go" title="Click to login.">
                                    <input name="methodToCall" type="hidden" value="login" />
                                </html:form>
                            </c:if>
                            <html:form action="/backdoorlogin.do" method="post" style="margin:0; display:inline">
                                <input name="imageField" type="submit" value="Logout" class="go" title="Click to logout.">
                                <input name="methodToCall" type="hidden" value="logout" />
                            </html:form> 
                        </c:otherwise> 
                    </c:choose>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<c:choose>
    <c:when test='${!empty channelTitle && !empty channelUrl}'>
        <div id="iframe_portlet_container_div">
            <portal:iframePortletContainer channelTitle="${channelTitle}" channelUrl="${channelUrl}" />
        </div>
    </c:when>
    <c:otherwise>
        <table border="0" width="100%"  cellspacing="0" cellpadding="0" id="iframe_portlet_container_table">
            <c:if test="${empty channelTitle && empty channelUrl}">
                <c:set var="motd" value="<%= (new org.kuali.kfs.sys.businessobject.defaultvalue.MessageOfTheDayFinder()).getValue() %>" scope="page"/>
                <c:if test="${!empty pageScope.motd}">
                    <tr valign="top" bgcolor="#FFFFFF">
                        <td width="15" class="leftback-focus">&nbsp;</td>
                        <td colspan="3">
                            <channel:portalChannelTop channelTitle="Message Of The Day" />
                            <div class="body">
                                <strong><c:out value="${pageScope.motd}"  /></strong>
                            </div>
                            <channel:portalChannelBottom />
                        </td>
                    </tr>
                </c:if>
            </c:if>
            <tr valign="top" bgcolor="#FFFFFF">
                <td width="15" class="leftback-focus">&nbsp;</td>
                <c:choose>
                    <%-- then default to tab based actions if they are not focusing in --%>
                    <c:when test='${selectedTab == "main"}'>
                        <portal:mainTab />
                    </c:when>
                    <c:when test='${selectedTab == "maintenance"}'>
                        <portal:maintenanceTab />
                    </c:when>
                    <c:when test='${selectedTab == "administration"}'>
                        <portal:administrationTab />
                    </c:when>
                    <c:when test='${selectedTab == "support"}'>
                    <br><br>Link to Help and Support page goes here
                </c:when>                    

                <%-- as backup go to the main menu index --%>
                <c:otherwise>
                    <portal:mainTab />
                </c:otherwise>
            </c:choose>
            </tr>
        </table>
    </c:otherwise>
</c:choose>
<div id="footer-copyright"><bean:message key="app.copyright" arg0="${ConfigProperties.current.year}" /></div>
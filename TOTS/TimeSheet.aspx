<%@ Page Title="" Language="C#" MasterPageFile="~/SingleLogin.Master" AutoEventWireup="true" CodeBehind="TimeSheet.aspx.cs" Inherits="TOTS.TimeSheet" %>

<%@ MasterType VirtualPath="~/SingleLogin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="ToTSStyle.css" rel="stylesheet" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Default" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadButton3">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDataForm1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeShop" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeProdBonus" />
                    <telerik:AjaxUpdatedControl ControlID="LabelUpdateTime" />
                    <telerik:AjaxUpdatedControl ControlID="LabelExceptionOutput" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeAttendence">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeShop">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeShop" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDropDownListApproval">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDropDownListApproval" />
                    <telerik:AjaxUpdatedControl ControlID="RadTextBoxReason" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <h2>Technician Online Time Sheet
    </h2>
    <table style="width: 100%">
        <tr>
            <td style="width: 50%">Pay Period</td>
            <td style="width: 50%"></td>
        </tr>
        <tr>
            <td style="width: 50%">
                <telerik:RadDropDownList ID="RadDropDownListPayPeriods" runat="server" DataSourceID="SqlDataSourcePayPeriods" DataTextField="Des" DataValueField="payrollId"></telerik:RadDropDownList>
                <asp:SqlDataSource ID="SqlDataSourcePayPeriods" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectPayrollPeriods]" ProviderName="<%$ ConnectionStrings:WebAppsConnectionString.ProviderName %>"></asp:SqlDataSource>
            </td>
            <td style="width: 50%">
                <telerik:RadButton ID="RadButton3" runat="server" Text="Update" OnClick="RadButton3_Click"></telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Label ID="LabelUpdateTime" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <div>
        <asp:HiddenField ID="HiddenFieldTechId" runat="server" />
    </div>

    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0">
        <Tabs>
            <telerik:RadTab Text="Summary"></telerik:RadTab>
            <telerik:RadTab Text="Production Bonus Detail"></telerik:RadTab>
            <telerik:RadTab Text="Daily Approval"></telerik:RadTab>
            <telerik:RadTab Text="Final Approval"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
        <telerik:RadPageView ID="RadPageView1" runat="server">
            <div>
                <table style="width: 100%">
                    <tr>
                        <td valign="Top" colspan="2">
                            <div>
                                <telerik:RadDataForm ID="RadDataForm1" runat="server" DataSourceID="SqlDataSourceTechTimeCalc2">
                                    <ItemTemplate>
                                        <table style="width: 100%">
                                            <tr>
                                                <td valign="Top">
                                                    <h4>Information
                                                    </h4>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 60%">Technician Name
                                                            </td>
                                                            <td style="width: 40%">
                                                                <%# Eval("Name") %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Excede EmpId
                                                            </td>
                                                            <td>
                                                                <%# Eval("EmpId") %>
                                                            </td>
                                                        </tr>
                                                        <%--   <tr>
                                                            <td>Idle Rate
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:C}", Eval("IdleRate") ) %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Floor Rate
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:C}", Eval("ShopRate") ) %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Weighted Rate
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:C}", Eval("WeightedRate") ) %>
                                                            </td>
                                                        </tr>--%>
                                                    </table>
                                                </td>
                                                <td valign="Top">
                                                    <h4>Performance Indicators
                                                    </h4>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 75%">Labor Completed (Billed)
                                                            </td>
                                                            <td style="width: 25%">
                                                                <%# Eval("LaborGuideBill") %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Labor Completed (Actual)
                                                            </td>
                                                            <td>
                                                                <%# Eval("LaborGuideActual") %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Efficiency
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:P}", Eval("Efficiency") ) %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Productivity
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:P}", Eval("Productivity") ) %>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>Production Time
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:0.00}", Eval("ProductionTime") ) %> Hrs
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="Top">
                                                    <h4>Clocked Hours
                                                    </h4>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 75%">Attendence Week 1 
                                                            </td>
                                                            <td style="width: 25%">
                                                                <%# String.Format("{0:0.00}", Eval("AttendenceWeek1") ) %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Attendence Week 2
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:0.00}", Eval("AttendenceWeek2") ) %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Over Time Week 1
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:0.00}", Eval("OverTimeWeek1") ) %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Over Time Week 2
                                                            </td>
                                                            <td>
                                                                <%# String.Format("{0:0.00}", Eval("OverTimeWeek2") ) %> Hrs
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Shop Time Week 1</td>
                                                            <td><%# String.Format("{0:0.00}", Eval("ShopTimeWeek1") ) %> Hrs</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Shop Time Week 2</td>
                                                            <td><%# String.Format("{0:0.00}", Eval("ShopTimeWeek2") ) %> Hrs</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Idle Time Week 1</td>
                                                            <td><%# String.Format("{0:0.00}", Eval("IdleTimeWeek1") ) %> Hrs</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Idle Time Week 2</td>
                                                            <td><%# String.Format("{0:0.00}", Eval("IdleTimeWeek2") ) %> Hrs</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <%-- <td valign="Top">
                                                    <h4>Pay Estimates
                                                    </h4>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 75%">Regular Pay</td>
                                                            <td style="width: 25%"><%# String.Format("{0:C}", Eval("RegPay") ) %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Overtime Pay</td>
                                                            <td><%# String.Format("{0:C}", Eval("OvertimePay") ) %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Idle Pay</td>
                                                            <td><%# String.Format("{0:C}", Eval("IdlePay") ) %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Production Bonus</td>
                                                            <td><%# String.Format("{0:C}", Eval("ProductionBonus") ) %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Estimated Total Pay</td>
                                                            <td><%# String.Format("{0:C}", Eval("PayTotal") ) %></td>
                                                        </tr>
                                                    </table>
                                                </td>--%>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadDataForm>
                                <div>
                                    <asp:SqlDataSource ID="SqlDataSourceTechTimeCalc2" runat="server" ConnectionString="<%$ ConnectionStrings:VVGExcedeConnectionString %>" SelectCommand="EXEC [user_sp_VVGDev_TTS_ServiceTechnicianTimeCalc] @payrollId = @payrollId,@techtype=@techtype,@brnid=@brnid, @empid=@empid">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                            <asp:Parameter DefaultValue="0" Name="techtype" />
                                            <asp:Parameter DefaultValue="000" Name="brnid" />
                                            <asp:ControlParameter ControlID="HiddenFieldEmpId" Name="empid" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td valign="Top" style="width: 50%">
                            <div>
                                <telerik:RadGrid ID="RadGridSingleTechTimeAttendence" runat="server" DataSourceID="SelectTechTimeSingleTechAttendance" GroupPanelPosition="Top" ShowFooter="True">
                                    <GroupingSettings RetainGroupFootersVisibility="true" />
                                    <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="false" Caption="Attendence / Lunch Entries">
                                        <GroupByExpressions>
                                            <telerik:GridGroupByExpression>
                                                <SelectFields>
                                                    <telerik:GridGroupByField FieldName="Weekday" FieldAlias="Weekday" />
                                                </SelectFields>
                                                <GroupByFields>
                                                    <telerik:GridGroupByField FieldName="Weekday" SortOrder="Ascending" />
                                                </GroupByFields>
                                            </telerik:GridGroupByExpression>
                                        </GroupByExpressions>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Des1" FilterControlAltText="Filter Des1 column" HeaderText="Type" SortExpression="Des1" UniqueName="Des1">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateStart" FilterControlAltText="Filter DateStart column" HeaderText="DateStart" SortExpression="DateStart" UniqueName="DateStart" DataType="System.DateTime">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="DateEnd" SortExpression="DateEnd" UniqueName="DateEnd" DataType="System.DateTime">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="NonPaidTime" DataType="System.Decimal" FilterControlAltText="Filter NonPaidTime column" HeaderText="Non-Paid Time" ReadOnly="True" SortExpression="NonPaidTime" UniqueName="NonPaidTime" DataFormatString="{0:0.00}" Aggregate="Sum">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PaidTime" DataType="System.Decimal" FilterControlAltText="Filter PaidTime column" HeaderText="Paid Time" ReadOnly="True" SortExpression="PaidTime" UniqueName="PaidTime" DataFormatString="{0:0.00}" Aggregate="Sum">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <asp:SqlDataSource ID="SelectTechTimeSingleTechAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectTechTimeSingleTechAttendanceV2] @empid = @empid, @payrollId = @payrollId">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenFieldEmpId" Name="empid" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <div>
                                <asp:Label ID="LabelExceptionOutput" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                        <td valign="Top" style="width: 50%">
                            <div>
                                <telerik:RadGrid ID="RadGridSingleTechTimeShop" runat="server" DataSourceID="SelectTechTimeSingleTechShop" GroupPanelPosition="Top" ShowFooter="True">
                                    <GroupingSettings RetainGroupFootersVisibility="true" />
                                    <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="false" Caption="Shop Floor Entries">
                                        <GroupByExpressions>
                                            <telerik:GridGroupByExpression>
                                                <SelectFields>
                                                    <telerik:GridGroupByField FieldName="Weekday" FieldAlias="Weekday" />
                                                </SelectFields>
                                                <GroupByFields>
                                                    <telerik:GridGroupByField FieldName="Weekday" SortOrder="Ascending" />
                                                </GroupByFields>
                                            </telerik:GridGroupByExpression>
                                        </GroupByExpressions>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Invoice" FilterControlAltText="Filter Invoice column" HeaderText="Invoice" SortExpression="Invoice" UniqueName="Invoice">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateStart" FilterControlAltText="Filter DateStart column" HeaderText="DateStart" SortExpression="DateStart" UniqueName="DateStart" DataType="System.DateTime">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DateEnd" FilterControlAltText="Filter DateEnd column" HeaderText="DateEnd" SortExpression="DateEnd" UniqueName="DateEnd" DataType="System.DateTime">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Duration" DataType="System.Decimal" FilterControlAltText="Filter Duration column" HeaderText="Duration" ReadOnly="True" SortExpression="Duration" UniqueName="Duration" DataFormatString="{0:0.00}" Aggregate="Sum">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Reason" FilterControlAltText="Filter Reason column" HeaderText="Reason" SortExpression="Reason" UniqueName="Reason">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <asp:SqlDataSource ID="SelectTechTimeSingleTechShop" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectTechTimeSingleTechShopFloor] @empid = @empid, @payrollId = @payrollId">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenFieldEmpId" Name="empid" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView2" runat="server">
            <div>
                <telerik:RadGrid ID="RadGridSingleTechTimeProdBonus" runat="server" DataSourceID="SelectTechTimeSingleTechProdBonus" ShowFooter="True">
                    <GroupingSettings RetainGroupFootersVisibility="true" />
                    <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="True" Caption="Production Bonus">
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldName="Type" FieldAlias="Type" />
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="Type" SortOrder="Ascending" />
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Type" FilterControlAltText="Filter Type column" HeaderText="Type" SortExpression="Type" UniqueName="Type" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateInvoice" FilterControlAltText="Filter DateInvoice column" HeaderText="DateInvoice" SortExpression="DateInvoice" UniqueName="DateInvoice" DataType="System.DateTime" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SlsId" FilterControlAltText="Filter SlsId column" HeaderText="SlsId" SortExpression="SlsId" UniqueName="SlsId" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OpsId" FilterControlAltText="Filter OpsId column" HeaderText="OpsId" SortExpression="OpsId" UniqueName="OpsId" ReadOnly="True" DataType="System.Int32">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CusName" FilterControlAltText="Filter CusName column" HeaderText="CusName" SortExpression="CusName" UniqueName="CusName" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SvItm" FilterControlAltText="Filter SvItm column" HeaderText="SvItm" SortExpression="SvItm" UniqueName="SvItm" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Des" FilterControlAltText="Filter Des column" HeaderText="Des" SortExpression="Des" UniqueName="Des" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HrsBill" DataType="System.Double" FilterControlAltText="Filter HrsBill column" HeaderText="HrsBill" ReadOnly="True" SortExpression="HrsBill" UniqueName="HrsBill" Aggregate="Sum">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HrsActual" FilterControlAltText="Filter HrsActual column" HeaderText="HrsActual" SortExpression="HrsActual" UniqueName="HrsActual" DataType="System.Double" ReadOnly="True" Aggregate="Sum">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Difference" FilterControlAltText="Filter Difference column" HeaderText="Difference" SortExpression="Difference" UniqueName="Difference" DataType="System.Double" ReadOnly="True" Aggregate="Sum">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="SelectTechTimeSingleTechProdBonus" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectTechTimeSingleTechProdBonus] @payrollId = @payrollId, @empid = @empid ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldEmpId" Name="empid" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView3" runat="server">
            <h2>Time Approval
            </h2>
            <table style="width: 100%">
                <tr>
                    <td valign="Top" style="width: 25%">Approval Type:
                    </td>
                    <td valign="Top" style="width: 75%">
                        <telerik:RadDropDownList ID="RadDropDownListApproval" runat="server" Width="50%" OnSelectedIndexChanged="RadDropDownListApproval_SelectedIndexChanged">
                            <Items>
                                <telerik:DropDownListItem Text="I approve my time punches are accurate to the current date time." Value="1" />
                                <telerik:DropDownListItem Text="My time punches have errors." Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Reason:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="RadTextBoxReason" runat="server" TextMode="MultiLine" Width="100%" Height="12em" MaxLength="200">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="Top">Password:
                    </td>
                    <td>
                        <telerik:RadTextBox ID="RadTextBoxApprovalPassword" runat="server" TextMode="Password"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadButton ID="RadButtonSubmitApproval" runat="server" Text="Submit" OnClick="RadButtonSubmitApproval_Click"></telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadLabel ID="RadLabelApprovalResponse" runat="server"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

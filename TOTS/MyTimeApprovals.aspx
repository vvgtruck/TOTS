<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeBehind="MyTimeApprovals.aspx.cs" Inherits="TOTS.MyTimeApprovals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <%--CheckBoxes--%>
            <telerik:AjaxSetting AjaxControlID="RadButtonUpdate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="TimeApproval" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadDataFormTechTime" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeAttendence">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDataFormTechTime">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDataFormTechTime" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadPageLayout runat="server" ID="RadPageLayout1">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h1>My Time Approvals </h1>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <telerik:RadPageLayout runat="server" ID="RadPageLayout2">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" HiddenXs="true">
                        <table>
                            <tr>
                                <td>For Pay Period
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadDropDownList ID="RadDropDownListPayPeriods" runat="server" DataSourceID="SqlDataSourcePayPeriods" DataTextField="Des" DataValueField="payrollId" Width="400px"></telerik:RadDropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourcePayPeriods" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SelectPayrollPeriods]" ProviderName="<%$ ConnectionStrings:VVGTechnicianConnectionString.ProviderName %>"></asp:SqlDataSource>
                                </td>
                                <td>
                                    <telerik:RadButton ID="RadButtonUpdate" runat="server" Text="Update" OnClick="RadButtonUpdate_Click"></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <asp:HiddenField ID="HiddenFieldEmpIdUser" runat="server" />
                            <asp:HiddenField ID="HiddenFieldEmpNameUser" runat="server" />
                            <asp:HiddenField ID="HiddenFieldWspIdUser" runat="server" />
                        </div>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn>
                        <telerik:RadDataForm ID="RadDataFormTechTime" runat="server" DataSourceID="SqlDataSourceTechTimeCalc">
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
                                                <%--                                                <tr>
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
                                                    <td style="width: 75%">Attendence Time
                                                    </td>
                                                    <td style="width: 25%">
                                                        <%# string.Format("{0:0.00}",(decimal.Parse((Eval("AttendenceWeek1","{0:0.00}"))) + decimal.Parse((Eval("AttendenceWeek2","{0:0.00}")))))   %> Hrs
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Over Time 
                                                    </td>
                                                    <td>
                                                        <%# string.Format("{0:0.00}",(decimal.Parse((Eval("OverTimeWeek1","{0:0.00}"))) + decimal.Parse((Eval("OverTimeWeek2","{0:0.00}")))))   %> Hrs
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Double Time 
                                                    </td>
                                                    <td>
                                                        <%# string.Format("{0:0.00}",(decimal.Parse((Eval("DoubleTimeWeek1","{0:0.00}"))) + decimal.Parse((Eval("DoubleTimeWeek2","{0:0.00}")))))   %> Hrs
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Idle Time</td>
                                                    <td>
                                                        <%# string.Format("{0:0.00}",(decimal.Parse((Eval("IdleTimeWeek1","{0:0.00}"))) + decimal.Parse((Eval("IdleTimeWeek2","{0:0.00}")))))   %> Hrs
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <%--                         <td valign="Top">
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
                        <asp:SqlDataSource ID="SqlDataSourceTechTimeCalc" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_TechnicianTimeCalc] @payrollId, @brnid, @techtype, @empid">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                <asp:Parameter DefaultValue="000" Name="brnid" />
                                <asp:Parameter DefaultValue="0" Name="techtype" />
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12" SpanMd="6" SpanSm="6" HiddenXs="true">
                        <%--  Time Information Approving--%>
                        <telerik:RadGrid ID="RadGridSingleTechTimeAttendence" runat="server" DataSourceID="SelectTechTimeSingleTechAttendance" GroupPanelPosition="Top" ShowFooter="True" OnItemCommand="RadGridSingleTechTimeAttendence_ItemCommand" OnItemDataBound="RadGridSingleTechTimeAttendence_ItemDataBound">
                            <GroupingSettings RetainGroupFootersVisibility="true" />
                            <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="false" Caption="Attendence / Lunch Entries">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="WeekDay" FilterControlAltText="Filter WeekDay column" HeaderText="WeekDay" SortExpression="WeekDay" UniqueName="WeekDay">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Lunch" DataType="System.Decimal" FilterControlAltText="Filter Lunch column" HeaderText="Lunch" ReadOnly="True" SortExpression="Lunch" UniqueName="Lunch" DataFormatString="{0:0.00}" Aggregate="Sum">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Attendence" DataType="System.Decimal" FilterControlAltText="Filter Attendence column" HeaderText="Attendence" ReadOnly="True" SortExpression="Attendence" UniqueName="Attendence" DataFormatString="{0:0.00}" Aggregate="Sum">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Shop" DataType="System.Decimal" FilterControlAltText="Filter Shop column" HeaderText="Shop Time" ReadOnly="True" SortExpression="Shop" UniqueName="Shop" DataFormatString="{0:0.00}" Aggregate="Sum">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="Attendence,Shop" Expression="{0}-{1}" HeaderText="Idle Time" UniqueName="Idle" DataFormatString="{0:0.00}" DataType="System.Decimal" Aggregate="Sum">
                                    </telerik:GridCalculatedColumn>
                                    <telerik:GridButtonColumn HeaderText="Approve"
                                        SortExpression="Approve" Text="Approve Day" UniqueName="Approve"
                                        CommandName="Approve">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="Approval" FilterControlAltText="Filter Approval column" HeaderText="Approval" ReadOnly="True" SortExpression="Approval" UniqueName="Approval">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ApproveTime" FilterControlAltText="Filter ApproveTime column" HeaderText="Approved on:" ReadOnly="True" SortExpression="ApproveTime" UniqueName="ApproveTime">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ApproveName" FilterControlAltText="Filter ApproveName column" HeaderText="Approved By:" ReadOnly="True" SortExpression="ApproveName" UniqueName="ApproveName">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="SelectTechTimeSingleTechAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SingleTechApproval] @empid, @payrollId">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TOTS.Home" %>


<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <%--CheckBoxes--%>
            <telerik:AjaxSetting AjaxControlID="RadButtonUpdate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDataFormTechTime" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="HiddenFieldTechId" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadLabelOutput" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadPageLayout runat="server" ID="RadPageLayout1">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h1>Hi
                            <telerik:RadLabel ID="RadLabelUsernameGreeting" runat="server"></telerik:RadLabel>
                        </h1>
                        <h2>Welcome to the Velocity Technician Portal </h2>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn HiddenMd="true" HiddenSm="true" HiddenXs="true">
                        <h3>View my Current Pay Hours & Metrics</h3>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <telerik:RadPageLayout runat="server" ID="Content1">
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
                                    <asp:SqlDataSource ID="SqlDataSourcePayPeriods" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectPayrollPeriods]" ProviderName="<%$ ConnectionStrings:WebAppsConnectionString.ProviderName %>"></asp:SqlDataSource>
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
                    <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" HiddenXs="true">
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
                        <asp:SqlDataSource ID="SqlDataSourceTechTimeCalc" runat="server" ConnectionString="<%$ ConnectionStrings:VVGExcedeConnectionString %>" SelectCommand="EXEC [user_sp_VVGDev_TTS_ServiceTechnicianTimeCalc] @payrollId = @payrollId,@techtype=@techtype,@brnid=@brnid, @empid=@empid">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                <asp:Parameter DefaultValue="0" Name="techtype" />
                                <asp:Parameter DefaultValue="000" Name="brnid" />
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>


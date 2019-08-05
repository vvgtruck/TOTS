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
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeAttendence">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDropDownListApproval">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TimeApprovalReason" LoadingPanelID="RadAjaxLoadingPanel1" />
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
                                    <telerik:GridCalculatedColumn DataFields="Attendence,Shop" Expression="{0}-{1}" HeaderText="Idle Time" UniqueName="Idle" DataFormatString="{0:0.00}" DataType="System.Decimal">
                                    </telerik:GridCalculatedColumn>
                                    <telerik:GridButtonColumn HeaderText="Approve"
                                        SortExpression="Approve" Text="Approve Day" UniqueName="Approve"
                                        CommandName="Approve">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="Approval" FilterControlAltText="Filter Approval column" HeaderText="Approval" ReadOnly="True" SortExpression="Approval" UniqueName="Approval">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="SelectTechTimeSingleTechAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_SelectTechTimeSingleTechApprovalV2] @empid, @payrollId">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </telerik:LayoutColumn>
<%--                    <telerik:LayoutColumn Span="6" SpanMd="6" SpanSm="6" HiddenXs="true">
                        <div id="TimeApproval" runat="server" visible="false">
                            <table style="width: 100%">
                                <tr>
                                    <td valign="Top" style="width: 25%">Approval Date:
                                    </td>
                                    <td valign="Top" style="width: 75%">
                                        <telerik:RadDatePicker ID="RadDatePicker" runat="server">
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="Top" style="width: 25%">Approval Type:
                                    </td>
                                    <td valign="Top" style="width: 75%">
                                        <telerik:RadDropDownList ID="RadDropDownListApproval" runat="server" Width="100%" OnSelectedIndexChanged="RadDropDownListApproval_SelectedIndexChanged" AutoPostBack="true">
                                            <Items>
                                                <telerik:DropDownListItem Text="I approve my time punches are accurate to the current date time." Value="1" />
                                                <telerik:DropDownListItem Text="My time punches have errors." Value="0" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </td>
                                </tr>
                                <tr id="TimeApprovalReason" runat="server" visible="false">
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
                        </div>
                    </telerik:LayoutColumn>--%>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>

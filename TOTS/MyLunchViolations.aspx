<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeBehind="MyLunchViolations.aspx.cs" Inherits="TOTS.MyLunchViolations" %>

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
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeLunchViolations" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeLunchViolations">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeLunchViolations" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="RadWindowWaiver" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadPageLayout runat="server" ID="RadPageLayout1">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h1>Lunch Violations</h1>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <telerik:RadWindow RenderMode="Lightweight" ID="RadWindowWaiver" runat="server" Width="425px" Height="550px" Modal="true" Style="z-index: 100001;">
        <ContentTemplate>
            <p style="text-align: center;">
                Waiver Box
            </p>
        </ContentTemplate>
    </telerik:RadWindow>
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
                    <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" HiddenXs="true">
                        <telerik:RadGrid ID="RadGridSingleTechTimeLunchViolations" runat="server" DataSourceID="SelectTechTimeLunchViolations" GroupPanelPosition="Top" ShowFooter="True" OnItemCommand="RadGridSingleTechTimeLunchViolations_ItemCommand" OnItemDataBound="RadGridSingleTechTimeLunchViolations_ItemDataBound">
                            <GroupingSettings RetainGroupFootersVisibility="true" />
                            <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="false" Caption="Lunch Violations">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Violation" FilterControlAltText="Filter Violation column" HeaderText="Violation" SortExpression="Violation" UniqueName="Violation">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ShiftStart" FilterControlAltText="Filter ShiftStart column" HeaderText="ShiftStart" SortExpression="ShiftStart" UniqueName="ShiftStart" DataType="System.DateTime">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ShiftEnd" FilterControlAltText="Filter ShiftEnd column" HeaderText="ShiftEnd" SortExpression="ShiftEnd" UniqueName="ShiftEnd" DataType="System.DateTime">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn DataTextField="Acknowledgment" HeaderText="Acknowledgments"
                                        SortExpression="Acknowledgement" Text="Acknowledge Violation" UniqueName="Acknowledgement"
                                        CommandName="Acknowledge">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="SelectTechTimeLunchViolations" runat="server" ConnectionString="<%$ ConnectionStrings:WebAppsConnectionString %>" SelectCommand="EXEC [VVGWebApps_SP_Service_LunchViolations_byEmp] @payrollId, @empid ">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
        </Rows>
    </telerik:RadPageLayout>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeBehind="MyTimeSheet.aspx.cs" Inherits="TOTS.MyTimeSheet" %>

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
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeShop" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeShop">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeShop" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeAttendence">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeAttendence" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadPageLayout runat="server" ID="RadPageLayout1">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h1>My Time Sheet </h1>
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
                                    <telerik:RadDropDownList ID="RadDropDownListPayPeriods" runat="server" DataSourceID="SqlDataSourcePayPeriods" DataTextField="Des" DataValueField="payrollId" Width="500px"></telerik:RadDropDownList>
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
                    <telerik:LayoutColumn Span="6" SpanMd="6" SpanSm="6" HiddenXs="true">
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
                                    <telerik:GridBoundColumn DataField="NonPaidTime" DataType="System.Decimal" FilterControlAltText="Filter NonPaidTime column" HeaderText="Lunch" ReadOnly="True" SortExpression="NonPaidTime" UniqueName="NonPaidTime" DataFormatString="{0:0.00}" Aggregate="Sum">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PaidTime" DataType="System.Decimal" FilterControlAltText="Filter PaidTime column" HeaderText="Attendence" ReadOnly="True" SortExpression="PaidTime" UniqueName="PaidTime" DataFormatString="{0:0.00}" Aggregate="Sum">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="SelectTechTimeSingleTechAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SingleTechAttendance] @empid, @payrollId">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenFieldEmpIdUser" Name="empid" PropertyName="Value" />
                                <asp:ControlParameter ControlID="RadDropDownListPayPeriods" Name="payrollId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </telerik:LayoutColumn>
                    <telerik:LayoutColumn Span="6" SpanMd="6" SpanSm="6" HiddenXs="true">
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
                        <asp:SqlDataSource ID="SelectTechTimeSingleTechShop" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SingleTechShopFloor] @empid, @payrollId">
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


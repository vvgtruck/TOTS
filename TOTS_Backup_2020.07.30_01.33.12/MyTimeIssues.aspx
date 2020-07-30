<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeBehind="MyTimeIssues.aspx.cs" Inherits="TOTS.MyTimeIssues" %>

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
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeTimeIssues" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeTimeIssues">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeTimeIssues" LoadingPanelID="RadAjaxLoadingPanel1" />
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
                        <h1>Time Issues</h1>
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
                    <telerik:LayoutColumn Span="8" SpanMd="8" SpanSm="8" HiddenXs="true">
                        <div>
                            <br />
                            The below grid will list all potential issues regarding technician lunch breaks and attendance.  Please Refer to the Employee Handbook found at https://hr.vvg.zone/formspolicies 
                        </div>
                        <br />
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" HiddenXs="true">
                        <telerik:RadGrid ID="RadGridSingleTechTimeTimeIssues" runat="server" DataSourceID="SelectTechTimeTimeIssues" GroupPanelPosition="Top" ShowFooter="True" OnItemCommand="RadGridSingleTechTimeTimeIssues_ItemCommand" OnItemDataBound="RadGridSingleTechTimeTimeIssues_ItemDataBound">
                            <GroupingSettings RetainGroupFootersVisibility="true" />
                            <MasterTableView AutoGenerateColumns="false" ShowGroupFooter="true" GroupsDefaultExpanded="false" Caption="Time Issues">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="EmpId" FilterControlAltText="Filter EmpId column" HeaderText="EmpId" SortExpression="EmpId" UniqueName="EmpId">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrnId" FilterControlAltText="Filter BrnId column" HeaderText="BrnId" SortExpression="BrnId" UniqueName="BrnId">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ShiftStart" FilterControlAltText="Filter ShiftStart column" HeaderText="ShiftStart" SortExpression="ShiftStart" UniqueName="ShiftStart" DataType="System.DateTime">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Issue" FilterControlAltText="Filter Issue column" HeaderText="Issue" SortExpression="Issue" UniqueName="Issue">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn UniqueName="Verbage">
                                        <ItemTemplate>
                                            <div>
                                                Was this action Voluntary or Involuntary?  
                                            </div>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn CommandName="Voluntary" Text="Voluntary (Dismiss)" UniqueName="Voluntary">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn CommandName="Involuntary" Text="Involuntary (Follow-Up)" UniqueName="Involuntary">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="Response" FilterControlAltText="Filter Response column" HeaderText="Response" ReadOnly="True" SortExpression="Response" UniqueName="Response">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="SelectTechTimeTimeIssues" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SingleTechTimeIssue] @payrollId, @empid ">
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

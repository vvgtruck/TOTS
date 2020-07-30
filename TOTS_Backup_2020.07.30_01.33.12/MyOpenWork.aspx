<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSingleMenu.Master" AutoEventWireup="true" CodeBehind="MyOpenWork.aspx.cs" Inherits="TOTS.MyOpenWork" %>

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
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeProdBonus" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGridSingleTechTimeProdBonus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridSingleTechTimeProdBonus" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadPageLayout runat="server" ID="RadPageLayout1">
        <Rows>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h1>My Work</h1>
                    </telerik:LayoutColumn>
                </Columns>
            </telerik:LayoutRow>
            <telerik:LayoutRow>
                <Columns>
                    <telerik:LayoutColumn CssClass="jumbotron">
                        <h3 style="color:red">If you have a labor review, please submit through the following link:
                        <a href="https://www.velocityvehiclegroup.com/labor-review-form" target="_blank">Labor Review Form
                        </a>
                        </h3>
                        <br />
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
                    <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" HiddenXs="true">
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
                        <asp:SqlDataSource ID="SelectTechTimeSingleTechProdBonus" runat="server" ConnectionString="<%$ ConnectionStrings:VVGTechnicianConnectionString %>" SelectCommand="EXEC [App_SingleTechProdBonus] @payrollId, @empid ">
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


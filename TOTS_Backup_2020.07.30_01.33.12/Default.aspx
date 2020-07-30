<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="initial-scale=1.0, minimum-scale=1, maximum-scale=1.0, user-scalable=no" />
    <link href="styles/default.css" rel="stylesheet" />
    <link href="styles/base.css" rel="stylesheet" />
    <link href="styles/custom.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600,700,800,900" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="mainlogin">
        <telerik:RadScriptManager runat="server"></telerik:RadScriptManager>
        <div id="wrapper">
            <telerik:RadPageLayout runat="server" ID="MasterLayout" GridType="Fluid">
                <Rows>
                    <%--Header--%>
                    <telerik:LayoutRow CssClass="header">
                        <Columns>
                            <%--Logo--%>
                            <telerik:LayoutColumn Span="12" SpanMd="12" SpanSm="12" SpanXs="12">
                                <a href="#" class="logo">
                                    <img src="/images/VVG-logo.png" alt="site logo" />
                                </a>
                            </telerik:LayoutColumn>
                            <telerik:LayoutColumn Span="10" SpanMd="3" SpanSm="12" SpanXs="12">
                            </telerik:LayoutColumn>
                        </Columns>
                    </telerik:LayoutRow>

                    <%--Main--%>

                    <telerik:LayoutRow>
                        <Columns>
                            <telerik:LayoutColumn CssClass="jumbotron">
                                <h1>Velocity Technician Portal </h1>
                            </telerik:LayoutColumn>
                        </Columns>
                    </telerik:LayoutRow>
                    <telerik:LayoutRow>
                        <Columns>
                            <telerik:LayoutColumn HiddenMd="false" HiddenSm="false" HiddenXs="false" CssClass="logintablecontainer">
                                <table class="logintable">
                                    <tr>
                                        <td>
                                            <h2>Username:</h2>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBoxUsername" runat="server"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h2>Password:
                                            </h2>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="RadTextBoxPassword" runat="server" TextMode="Password"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <telerik:RadButton runat="server" ID="RadButton1Submit" Text="Let's Go" ButtonType="SkinnedButton" OnClick="RadButton1Submit_Click"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <telerik:RadLabel ID="RadLabelOutcome" runat="server"></telerik:RadLabel>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:LayoutColumn>
                        </Columns>
                    </telerik:LayoutRow>


                    <%--Footer--%>
                    <telerik:LayoutRow>
                        <Columns>
                            <telerik:LayoutColumn CssClass="footer">
                                © 2019 Velocity Vehicle Group, 2429 Peck Rd, Whittier, CA 90601
                            </telerik:LayoutColumn>
                        </Columns>
                    </telerik:LayoutRow>
                </Rows>
            </telerik:RadPageLayout>
        </div>
    </form>
</body>
</html>

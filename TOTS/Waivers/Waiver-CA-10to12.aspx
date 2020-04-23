<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Waiver-CA-10to12.aspx.cs" Inherits="TOTS.Waivers.Waiver_CA_10to12" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="Styles/base.css" rel="stylesheet" />
    <link href="Styles/default.css" rel="stylesheet" />
    <link href="Styles/Custom.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
       <telerik:RadScriptManager runat="server"></telerik:RadScriptManager>
        <div>
            <img src="images/VVG-Logo.png" />
            <h3>Meal Waiver - 10 to 12 Hours
            </h3>
            <br />
            Employee Name : // Employee Number:
            <br />

            <span>This will cerfify that I regularly work a shift in excess of 10 hours and wish to waive one of the two meal periods I would otherwise be entitled to receive under California law.  In accordance with the requirement of state law, I hereby  voluntarily agree to waive one meal period during each day of work and will be paid for all working time, but not for the one duty-free meal period I receive.
            </span>
            <br />
            <br />
            <span>I also understand that I or the Employer may revoke this meal period waiver at any time by providing at least one days advance notice in writing of the decision to do so.  This waiver will remain in effect unti I or the Employee excedes the option to revoke it.
            </span>
            <br />
            <br />
            <span>
                <telerik:RadCheckBox ID="RadCheckboxAccept" runat="server" Text="I accept and acknowledge the company policy above.">

                </telerik:RadCheckBox>
                <telerik:RadDatePicker ID="RadDatePicker"></telerik:RadDatePicker>
            </span>
            <br />
            <br />
            <span>I acknowledge that I have read this waiver, understand it, and voluntarliy agree to its provisions.
            </span>
            <div>
                <telerik:RadTextBox ID="RadTextBoxEmpIdAgree" runat="server" Label="Employee ID #" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBoxPasswordAgree" runat="server" Label="Password" Width="200px" TextMode="Password"></telerik:RadTextBox>
                <telerik:RadButton ID="RadButtonWaiverAgree" runat="server" Text="I Acknowledge and Agree to this Waiver"></telerik:RadButton>
            </div>
            <br />
            <br />
            <span>I wish to revoke this Waiver.
            </span>
            <div>
                <telerik:RadTextBox ID="RadTextBoxEmpIdRevoke" runat="server" Label="Employee ID #" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBoxPasswordRevoke" runat="server" Label="Password" Width="200px" TextMode="Password"></telerik:RadTextBox>
                <telerik:RadButton ID="RadButtonWaiverRevoke" runat="server" Text="I Acknowledge and Revoke this Waiver"></telerik:RadButton>
            </div>

            <%--      When an employee types in their EmpId, the name should populate automatically.--%>
        </div>
    </form>
</body>
</html>

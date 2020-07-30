<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Waiver.aspx.cs" Inherits="TOTS.Waiver" %>

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
            <h3>Meal Period Waiver
            </h3>
            <br />
            <span>California law and Velocity Vehicle Group (the "Company") policy require that employees be provided a thirty (30) minute off duty meal period whenever their work period exceeds five (5) hours in a work day.  
                An employee may waive his or her right to the meal period in limited circumstances.  If a work period of not more than six hours will complete the employees shift for the work day, the meal period may be waived by mutual consent of the Company and the employee.
            </span>
            <br />
            <br />
            <span>Employees who do not agree to waive their meal period in the circumstances described above will be provided a 30 minute off duty meal period in accordance with California law and Company policy.
            </span>
            <br />
            <br />
            <span>I understand and acknowledge that I or the Company may revoke this waiver at any time by re-signing and dating this waiver below.  I also understand that this waiver does not relieve me of my obligation to comply with the Company's meal and rest period policy with regard to the meal and rest period not covered by this waiver, and that my failure to do so may result in disciplinary action up to and including termination of employment.  
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

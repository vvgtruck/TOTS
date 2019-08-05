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
                An employee may waive his or her right to the meal period in limited circumstances.  if a work period of not more than six hours will commplete the employees shift 
                for the work day, the meal period may be waived by mutual consent of Company and the employee.
            </span>
            <div>
                <telerik:RadCheckBox ID="RadCheckboxWaiver" runat="server" Text="By Checking the box, I affirm my agreement to voluntarily waive my 30 minute off duty meal period in those circumstances in which I work more than five (5) hours in a work shift but my total work period for that work day does not exceed six (6) hours."></telerik:RadCheckBox>
            </div>
            <span>Employees who do not agree to waive their meal period in the circumstances describved above will be provided a 30 minute off duty meal period in accordance with California law and Company policy.
            </span>
            <span>I understand and acknowledge that I or the Company may revoke this waiver at any time by re-signing and dating this waiver below.  I also understand that this waiver does not relieve me of my obligation to comply with the Company's meal and rest period poilicy with regard to the meal and rest period not covered by this waiver, and that my failure to do so may result in disciplinary action up to and including termination of employment.  I acknowledge that I have read this waiver, understand it, and voluntarliy agree to its provisions.
            </span>
            <br />
            <div>
                <telerik:RadTextBox ID="RadTextBoxEmpName" runat="server" Label="Typed Name" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBoxEmpId" runat="server" Label="Employee ID #" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBoxPassword" runat="server" Label="Password" Width="200px" TextMode="Password"></telerik:RadTextBox>
                <telerik:RadButton ID="RadButtonWaiver" runat="server" Text="I Acknowledge and Agree to this Waiver"></telerik:RadButton>
            </div>
            <br />
            <br />
            <span>I wish to revoke this Meal Period Waiver.
            </span>
            <div>
                <telerik:RadTextBox ID="RadTextBox1" runat="server" Label="Typed Name" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBox2" runat="server" Label="Employee ID #" Width="200px"></telerik:RadTextBox>
                <telerik:RadTextBox ID="RadTextBox3" runat="server" Label="Password" Width="200px" TextMode="Password"></telerik:RadTextBox>
                <telerik:RadButton ID="RadButtonRevoke" runat="server" Text="I Acknowledge and Revoke this Waiver"></telerik:RadButton>
            </div>
            <div>
                <telerik:RadButton ID="RadButtonClose" runat="server" Text="Close Waiver"></telerik:RadButton>
            </div>

      <%--      When an employee types in their EmpId, the name should populate automatically.--%>
        </div>
    </form>
</body>
</html>

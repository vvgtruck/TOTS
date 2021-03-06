﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


namespace TOTS
{
    public partial class TimeSheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadButton3_Click(object sender, EventArgs e)
        {
            LabelUpdateTime.Text = "Updated on: " + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
        }

        protected void RadButtonSubmitApproval_Click(object sender, EventArgs e)
        {

            try
            {
                string reason;

                reason = "No Reason Provided";

                if (RadTextBoxReason.Text.Length >= 3)
                {
                    reason = RadTextBoxReason.Text;
                }

                HiddenField MPEmpId = (HiddenField)Master.FindControl("HiddenFieldEmpId");

                string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
                using (var conn = new SqlConnection(connectionString))
                using (var command = new SqlCommand("VVGWebApps_SP_Service_InsertTechTimeApproval", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    conn.Open();

                    // Add input parameter

                    SqlParameter Approval = new SqlParameter();
                    Approval.ParameterName = "@Approval";
                    Approval.Value = RadDropDownListApproval.SelectedValue;
                    Approval.SqlDbType = SqlDbType.Int;
                    Approval.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Approval);

                    SqlParameter PrdId = new SqlParameter();
                    PrdId.ParameterName = "@PrdId";
                    PrdId.Value = RadDropDownListPayPeriods.SelectedValue;
                    PrdId.SqlDbType = SqlDbType.Int;
                    PrdId.Direction = ParameterDirection.Input;
                    command.Parameters.Add(PrdId);

                    SqlParameter Reason = new SqlParameter();
                    Reason.ParameterName = "@Reason";
                    Reason.Value = reason;
                    Reason.SqlDbType = SqlDbType.VarChar;
                    Reason.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Reason);

                    SqlParameter EmpId = new SqlParameter();
                    EmpId.ParameterName = "@EmpId";
                    EmpId.Value = MPEmpId.Value;
                    EmpId.SqlDbType = SqlDbType.VarChar;
                    EmpId.Size = 25;
                    EmpId.Direction = ParameterDirection.Input;
                    command.Parameters.Add(EmpId);

                    SqlParameter Password = new SqlParameter();
                    Password.ParameterName = "@Password";
                    Password.Value = RadTextBoxApprovalPassword.Text;
                    Password.SqlDbType = SqlDbType.VarChar;
                    Password.Size = 25;
                    Password.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Password);

                    // Add output parameters

                    SqlParameter Validated = new SqlParameter();
                    Validated.ParameterName = "@Validated";
                    Validated.SqlDbType = SqlDbType.Int;
                    Validated.Direction = ParameterDirection.Output;
                    command.Parameters.Add(Validated);

                    //execute
                    command.ExecuteNonQuery();

                    conn.Close();
                    conn.Dispose();

                    if (Validated.Value.ToString() == "1")
                    {
                        RadLabelApprovalResponse.Text = "Response has been logged successfully";
                    }

                    if (Validated.Value.ToString() == "0")
                    {
                        RadLabelApprovalResponse.Text = "Response has not been logged successfully";
                    }
                }
            }
            catch (Exception x)
            {
                RadLabelApprovalResponse.Text = "There was an error entering data.  "  + x.ToString();
            }

        }

        protected void RadDropDownListApproval_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            if (RadDropDownListApproval.SelectedIndex == 0)
            {
                RadTextBoxReason.Visible = false;
            }
            else
            {
                RadTextBoxReason.Visible = true;
            }
        }
    }
}
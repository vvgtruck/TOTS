using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace TOTS
{
    public partial class MyTimeApprovals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HiddenFieldEmpNameUser.Value == null || HiddenFieldEmpNameUser.Value == string.Empty)
            {
                try
                {
                    HiddenFieldEmpIdUser.Value = Session["EmpId"].ToString();
                    HiddenFieldEmpNameUser.Value = Session["EmpName"].ToString();
                    HiddenFieldWspIdUser.Value = Session["WspId"].ToString();
                }
                catch
                {
                    Server.Transfer("/Default.aspx?timeout=yes");
                }
            }
        }

        protected void RadButtonUpdate_Click(object sender, EventArgs e)
        {
            //RadGridSingleTechTimeAttendence.Rebind();
            //TimeApproval.Visible = true;

            //RadTextBoxApprovalPassword.Text = string.Empty;
            //RadTextBoxReason.Text = string.Empty;
            //RadLabelApprovalResponse.Text = string.Empty;

            RadDataFormTechTime.Rebind();


        }
        protected void RadButtonSubmitApproval_Click(object sender, EventArgs e)
        {

            //try
            //{
            //    string reason;

            //    reason = "No Reason Provided";

            //    if (RadTextBoxReason.Text.Length >= 3)
            //    {
            //        reason = RadTextBoxReason.Text;
            //    }

            //    HiddenField MPEmpId = (HiddenField)Master.FindControl("HiddenFieldEmpId");

            //    string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            //    using (var conn = new SqlConnection(connectionString))
            //    using (var command = new SqlCommand("VVGWebApps_SP_Service_InsertTechTimeApproval", conn)
            //    {
            //        CommandType = CommandType.StoredProcedure
            //    })
            //    {
            //        conn.Open();

            //        // Add input parameter

            //        SqlParameter Approval = new SqlParameter();
            //        Approval.ParameterName = "@Approval";
            //        Approval.Value = RadDropDownListApproval.SelectedValue;
            //        Approval.SqlDbType = SqlDbType.Int;
            //        Approval.Direction = ParameterDirection.Input;
            //        command.Parameters.Add(Approval);

            //        SqlParameter PrdId = new SqlParameter();
            //        PrdId.ParameterName = "@PrdId";
            //        PrdId.Value = RadDropDownListPayPeriods.SelectedValue;
            //        PrdId.SqlDbType = SqlDbType.Int;
            //        PrdId.Direction = ParameterDirection.Input;
            //        command.Parameters.Add(PrdId);

            //        SqlParameter Reason = new SqlParameter();
            //        Reason.ParameterName = "@Reason";
            //        Reason.Value = reason;
            //        Reason.SqlDbType = SqlDbType.VarChar;
            //        Reason.Direction = ParameterDirection.Input;
            //        command.Parameters.Add(Reason);

            //        SqlParameter EmpId = new SqlParameter();
            //        EmpId.ParameterName = "@EmpId";
            //        EmpId.Value = HiddenFieldEmpIdUser.Value;
            //        EmpId.SqlDbType = SqlDbType.VarChar;
            //        EmpId.Size = 25;
            //        EmpId.Direction = ParameterDirection.Input;
            //        command.Parameters.Add(EmpId);

            //        SqlParameter Password = new SqlParameter();
            //        Password.ParameterName = "@Password";
            //        Password.Value = RadTextBoxApprovalPassword.Text;
            //        Password.SqlDbType = SqlDbType.VarChar;
            //        Password.Size = 25;
            //        Password.Direction = ParameterDirection.Input;
            //        command.Parameters.Add(Password);

            //        // Add output parameters

            //        SqlParameter Validated = new SqlParameter();
            //        Validated.ParameterName = "@Validated";
            //        Validated.SqlDbType = SqlDbType.Int;
            //        Validated.Direction = ParameterDirection.Output;
            //        command.Parameters.Add(Validated);

            //        //execute
            //        command.ExecuteNonQuery();

            //        conn.Close();
            //        conn.Dispose();

            //        if (Validated.Value.ToString() == "1")
            //        {
            //            RadLabelApprovalResponse.Text = "Response has been logged successfully";
            //        }

            //        if (Validated.Value.ToString() == "0")
            //        {
            //            RadLabelApprovalResponse.Text = "Response has not been logged successfully";
            //        }

            //        RadTextBoxApprovalPassword.Text = string.Empty;

            //    }
            //}
            //catch (Exception x)
            //{
            //    RadLabelApprovalResponse.Text = "There was an error entering data.  " + x.ToString();
            //}

        }

        protected void RadDropDownListApproval_SelectedIndexChanged(object sender, DropDownListEventArgs e)
        {
            //if (RadDropDownListApproval.SelectedIndex == 0)
            //{
            //    TimeApprovalReason.Visible = false;
            //}
            //else
            //{
            //    TimeApprovalReason.Visible = true;
            //}
        }

        protected void RadGridSingleTechTimeAttendence_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                GridDataItem item = (GridDataItem)e.Item;

                string s_WeekDay = item["WeekDay"].Text;
                string s_attendence = item["Attendence"].Text;
                string s_lunch = item["lunch"].Text;
                string s_shop = item["shop"].Text;
                string s_EmpIdUser = HiddenFieldEmpIdUser.Value;

                // SQL Call for Approving Check Request By Id
                string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGTechnician;UID=sa;PWD=Network9899;";
                using (var conn = new SqlConnection(connectionString))
                using (var command = new SqlCommand("App_SingleTechApproval_ApproveDay", conn)
                {
                    CommandType = CommandType.StoredProcedure
                })
                {
                    conn.Open();

                    // Add input parameter
                    SqlParameter EmpId = new SqlParameter();
                    EmpId.ParameterName = "@empid";
                    EmpId.Value = s_EmpIdUser;
                    EmpId.SqlDbType = SqlDbType.VarChar;
                    EmpId.Size = 12;
                    EmpId.Direction = ParameterDirection.Input;
                    command.Parameters.Add(EmpId);

                    SqlParameter Weekday = new SqlParameter();
                    Weekday.ParameterName = "@weekday";
                    Weekday.Value = s_WeekDay;
                    Weekday.SqlDbType = SqlDbType.VarChar;
                    Weekday.Size = 50;
                    Weekday.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Weekday);

                    SqlParameter Attendence = new SqlParameter();
                    Attendence.ParameterName = "@attendence";
                    Attendence.Value = float.Parse(s_attendence);
                    Attendence.SqlDbType = SqlDbType.Decimal;
                    Attendence.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Attendence);

                    SqlParameter Lunch = new SqlParameter();
                    Lunch.ParameterName = "@lunch";
                    Lunch.Value = float.Parse(s_lunch);
                    Lunch.SqlDbType = SqlDbType.Decimal;
                    Lunch.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Lunch);

                    SqlParameter Shop = new SqlParameter();
                    Shop.ParameterName = "@shop";
                    Shop.Value = float.Parse(s_shop);
                    Shop.SqlDbType = SqlDbType.Decimal;
                    Shop.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Shop);

                    //execute
                    command.ExecuteNonQuery();

                    conn.Close();
                    conn.Dispose();

                }

                RadGridSingleTechTimeAttendence.Rebind();
            }
        }

        protected void RadGridSingleTechTimeAttendence_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;

                //Disable based on Idle Time
                //if (float.Parse(dataBoundItem["Idle"].Text) >= .21)
                //{
                //    dataBoundItem["Approve"].Enabled = false;
                //    dataBoundItem["Approve"].Text = "Issue: Idle Time";
                //}
                //else
                //{
                //    dataBoundItem["Approve"].Enabled = true;
                //}

                //Disable based on Shop > Attendence
                if (float.Parse(dataBoundItem["Shop"].Text) > float.Parse(dataBoundItem["Attendence"].Text))
                {
                    dataBoundItem["Approve"].Enabled = false;
                    dataBoundItem["Approve"].Text = "Issue: Shop > Attendance";
                }
                else
                {
                    dataBoundItem["Approve"].Enabled = true;
                }




                if (dataBoundItem["Approval"].Text == "Approved")
                {
                    dataBoundItem["WeekDay"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Lunch"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Shop"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Attendence"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Idle"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Approve"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Approval"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ApproveTime"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ApproveName"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                }
                else
                {
                    dataBoundItem["WeekDay"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Lunch"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Shop"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Attendence"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Idle"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Approve"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Approval"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ApproveTime"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ApproveName"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                }
            }
        }
    }
}
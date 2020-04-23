﻿using System;
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
    public partial class MyTimeIssues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //HiddenFieldEmpIdUser.Value = "12185";
            //HiddenFieldEmpNameUser.Value = "Brandon";
            //HiddenFieldWspIdUser.Value = "28";

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
            RadGridSingleTechTimeTimeIssues.Rebind();
        }

        protected void RadGridSingleTechTimeTimeIssues_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Acknowledge")
            {
                GridDataItem item = (GridDataItem)e.Item;

                string s_Issue = item["Issue"].Text;
                string s_ShiftStart = item["ShiftStart"].Text;
                string s_BrnId = item["BrnId"].Text;
                string s_EmpIdUser = HiddenFieldEmpIdUser.Value;
                string s_Response = "Yes";

                DateTime dt_ShiftStart = DateTime.Parse(s_ShiftStart);

                //Exec Code for adding acknowledgement if it's waivable, mark it on the SQL table (Waiver = 1).
                string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGTechnician;UID=sa;PWD=Network9899;";
                using (var conn = new SqlConnection(connectionString))
                using (var command = new SqlCommand("App_SingleTechTimeIssue_Response", conn)
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

                    SqlParameter BrnId = new SqlParameter();
                    BrnId.ParameterName = "@violation";
                    BrnId.Value = s_BrnId;
                    BrnId.SqlDbType = SqlDbType.VarChar;
                    BrnId.Size = 3;
                    BrnId.Direction = ParameterDirection.Input;
                    command.Parameters.Add(BrnId);

                    SqlParameter ShiftStart = new SqlParameter();
                    ShiftStart.ParameterName = "@ShiftStart";
                    ShiftStart.Value = dt_ShiftStart;
                    ShiftStart.SqlDbType = SqlDbType.DateTime;
                    ShiftStart.Direction = ParameterDirection.Input;
                    command.Parameters.Add(ShiftStart);

                    SqlParameter Issue = new SqlParameter();
                    Issue.ParameterName = "@Violation";
                    Issue.Value = s_Issue;
                    Issue.SqlDbType = SqlDbType.VarChar;
                    Issue.Size = 100;
                    Issue.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Issue);

                    SqlParameter Response = new SqlParameter();
                    Response.ParameterName = "@Response";
                    Response.Value = s_Response;
                    Response.SqlDbType = SqlDbType.VarChar;
                    Response.Size = 100;
                    Response.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Response);

                    //execute
                    command.ExecuteNonQuery();

                    conn.Close();
                    conn.Dispose();

                }

                //Refresh the grid so that the acknowledged line turns Yellow or Green.
                RadGridSingleTechTimeTimeIssues.Rebind();

            }
        }

        protected void RadGridSingleTechTimeTimeIssues_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;


                if (dataBoundItem["Acknowledge"].Text == "Acknowledged" && (dataBoundItem["WaiverComplete"].Text == "Yes" || dataBoundItem["WaiverComplete"].Text == "N/A"))
                {
                    dataBoundItem["TimeIssue"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    //dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    //dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    //dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                }
                else if (dataBoundItem["Acknowledge"].Text == "Acknowledged") 
                {
                    dataBoundItem["Issue"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    //dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    //dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(255, 255, 224);  //Light Yellow
                    //dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                }
                else
                {
                    dataBoundItem["TimeIssue"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    //dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    //dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    //dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                }
            }
        }
    }
}
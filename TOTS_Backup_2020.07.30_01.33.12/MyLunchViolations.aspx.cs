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
    public partial class MyLunchViolations : System.Web.UI.Page
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
            RadGridSingleTechTimeLunchViolations.Rebind();
        }

        protected void RadGridSingleTechTimeLunchViolations_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Acknowledge")
            {
                GridDataItem item = (GridDataItem)e.Item;

                string s_Violation = item["Violation"].Text;
                string s_ShiftStart = item["ShiftStart"].Text;
                string s_ShiftEnd = item["ShiftEnd"].Text;
                string s_EmpIdUser = HiddenFieldEmpIdUser.Value;

                int Waivable = 0;

                if (s_Violation.Contains("Waiver?") == true)

                {
                    Waivable = 1;
                }

                //Only pop up box if the violation is waivable?
                if (Waivable == 1)
                {
                    RadWindow window = new RadWindow();
                    window.ID = "RadWindowWaiver";
                    window.VisibleStatusbar = false;
                    window.VisibleOnPageLoad = true;
                    window.Height = 700;
                    window.Width = 900;
                    window.NavigateUrl = "/Waiver.aspx";
                    RadWindowWaiver.Controls.Add(window);
                }

                //Exec Code for adding acknowledgement if it's waivable, mark it on the SQL table (Waiver = 1).
                string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=Excede;UID=sa;PWD=Network9899;";
                using (var conn = new SqlConnection(connectionString))
                using (var command = new SqlCommand("user_sp_VVGDev_TOTS_AcknowledgeSingleViolation", conn)
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

                    SqlParameter Violation = new SqlParameter();
                    Violation.ParameterName = "@violation";
                    Violation.Value = s_Violation;
                    Violation.SqlDbType = SqlDbType.VarChar;
                    Violation.Size = 50;
                    Violation.Direction = ParameterDirection.Input;
                    command.Parameters.Add(Violation);

                    SqlParameter ShiftStart = new SqlParameter();
                    ShiftStart.ParameterName = "@ShiftStart";
                    ShiftStart.Value = DateTime.Parse(s_ShiftStart);
                    ShiftStart.SqlDbType = SqlDbType.DateTime;
                    ShiftStart.Direction = ParameterDirection.Input;
                    command.Parameters.Add(ShiftStart);

                    SqlParameter ShiftEnd = new SqlParameter();
                    ShiftEnd.ParameterName = "@ShiftEnd";
                    ShiftEnd.Value = DateTime.Parse(s_ShiftEnd);
                    ShiftEnd.SqlDbType = SqlDbType.DateTime;
                    ShiftEnd.Direction = ParameterDirection.Input;
                    command.Parameters.Add(ShiftEnd);

                    SqlParameter sqlWaivable = new SqlParameter();
                    sqlWaivable.ParameterName = "@Waivable";
                    sqlWaivable.Value = Waivable;
                    sqlWaivable.SqlDbType = SqlDbType.Bit;
                    sqlWaivable.Direction = ParameterDirection.Input;
                    command.Parameters.Add(sqlWaivable);

                    //execute
                    command.ExecuteNonQuery();

                    conn.Close();
                    conn.Dispose();

                }
                //Refresh the grid so that the acknowledged line turns Yellow or Green.
                RadGridSingleTechTimeLunchViolations.Rebind();

            }
        }

        protected void RadGridSingleTechTimeLunchViolations_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;


                if (dataBoundItem["Acknowledge"].Text == "Acknowledged" && (dataBoundItem["WaiverComplete"].Text == "Yes" || dataBoundItem["WaiverComplete"].Text == "N/A"))
                {
                    dataBoundItem["Violation"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                }
                else if (dataBoundItem["Acknowledge"].Text == "Acknowledged" && dataBoundItem["WaiverComplete"].Text == "No")
                {
                    dataBoundItem["Violation"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(255, 255, 224);  //Light Yellow
                    dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(255, 255, 224); //Light Yellow
                }
                else
                {
                    dataBoundItem["Violation"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["AcknowledgeButton"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Acknowledge"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["WaiverComplete"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                }
            }
        }
    }
}
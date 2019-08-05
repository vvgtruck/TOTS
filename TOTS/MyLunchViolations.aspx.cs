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

            HiddenFieldEmpIdUser.Value = "12185";
            HiddenFieldEmpNameUser.Value = "Brandon";
            HiddenFieldWspIdUser.Value = "28";

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

                //string s_Violation = item["Violation"].Text;
                //string s_ShiftStart = item["ShiftStart"].Text;
                //string s_ShiftEnd = item["ShitftEnd"].Text;
                //string s_EmpIdUser = HiddenFieldEmpIdUser.Value;

                //Only pop up box if the violation is waivable?
                //if (s_Violation == "WAIVABLE VIOLATION")
                {
                    RadWindow window = new RadWindow();
                    window.ID = "RadWindowWaiver";
                    window.VisibleStatusbar = false;
                    window.VisibleOnPageLoad = true;
                    window.Height = 700;
                    window.Width = 900;
                    window.NavigateUrl = "/Waiver.aspx";
                  //  window.NavigateUrl = "/Waiver.aspx?EmpId=" + s_EmpIdUser + "&Violation=" + s_Violation;
                    RadWindowWaiver.Controls.Add(window);


                }
                //Exec Code for adding acknowledgement if it's waivable, mark it on the SQL table (Waiver = 1).

                //Refresh the grid so that the acknowledged line turns Yellow or Green.
                RadGridSingleTechTimeLunchViolations.Rebind();

            }
        }

        protected void RadGridSingleTechTimeLunchViolations_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;


                if (dataBoundItem["Acknowledgement"].Text == "Acknowledged")
                {
                    dataBoundItem["Violation"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                    dataBoundItem["Acknowledgement"].BackColor = Color.FromArgb(198, 239, 206); //Light Green
                }
                else
                {
                    dataBoundItem["Violation"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ShiftStart"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["ShiftEnd"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                    dataBoundItem["Acknowledgement"].BackColor = Color.FromArgb(255, 199, 206); //Light Red
                }
            }
        }
    }
}
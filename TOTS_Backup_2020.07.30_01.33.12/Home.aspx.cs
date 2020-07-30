using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOTS
{
    public partial class Home : System.Web.UI.Page
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
                    RadLabelUsernameGreeting.Text = HiddenFieldEmpNameUser.Value.ToString();
                }
                catch
                {
                    Server.Transfer("/Default.aspx?timeout=yes");
                }
            }

            if (!IsPostBack)
            {

            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            RadDataFormTechTime.Rebind();
        }

        protected void RadButtonUpdate_Click(object sender, EventArgs e)
        {
            RadDataFormTechTime.Rebind();
        }
    }
}
using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                string timeout = Request.QueryString["timeout"];
                if (timeout == "yes")
                {
                    RadLabelOutcome.Text = "System Time Event - Please log back into continue";
                }
            }
            catch
            {

            }

            try
            {
                string timeout = Request.QueryString["invalid"];
                if (timeout == "yes")
                {
                    RadLabelOutcome.Text = "Invalid Access Attempt - Please login to continue";
                }
            }
            catch
            {

            }
        }
    }

    protected void RadButton1Submit_Click(object sender, EventArgs e)
    {
        string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
        using (var conn = new SqlConnection(connectionString))
        using (var command = new SqlCommand("VVGWebApps_TOTSSingleLogin_Validate", conn)
        {
            CommandType = CommandType.StoredProcedure
        })
        {
            conn.Open();

            // Add input parameter

            SqlParameter EmpId = new SqlParameter();
            EmpId.ParameterName = "@EmpId";
            EmpId.Value = RadTextBoxUsername.Text;
            EmpId.SqlDbType = SqlDbType.VarChar;
            EmpId.Size = 25;
            EmpId.Direction = ParameterDirection.Input;
            command.Parameters.Add(EmpId);

            SqlParameter Password = new SqlParameter();
            Password.ParameterName = "@Password";
            Password.Value = RadTextBoxPassword.Text;
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

            SqlParameter WspId = new SqlParameter();
            WspId.ParameterName = "@WspId";
            WspId.SqlDbType = SqlDbType.Int;
            WspId.Direction = ParameterDirection.Output;
            command.Parameters.Add(WspId);

            SqlParameter EmpName = new SqlParameter();
            EmpName.ParameterName = "@EmpName";
            EmpName.SqlDbType = SqlDbType.VarChar;
            EmpName.Size = 50;
            EmpName.Direction = ParameterDirection.Output;
            command.Parameters.Add(EmpName);

            //execute
            command.ExecuteNonQuery();

            conn.Close();
            conn.Dispose();

            if (Validated.Value.ToString() == "0")
            {
                RadLabelOutcome.Text = "Username, Password, or Role is Incorrect";
            }

            if (Validated.Value.ToString() == "1")
            {
                Session["WspId"] = WspId.Value.ToString();
                Session["EmpName"] = EmpName.Value.ToString();
                Session["EmpId"] = RadTextBoxUsername.Text;

                Session.Timeout = 60;

                Response.Redirect("/Home.aspx");
            }
        }
    }
}

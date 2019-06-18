using System;
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
    public partial class SingleLogin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                RadLabelAppTitle.Text = "Technician Online Time Sheet";
        }

        protected void RadButtonSubmitCredentials_Click(object sender, EventArgs e)
        {
            //Validate Excede Login 

            string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_iAppsSingleLogin_Validate", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                conn.Open();

                // Add input parameter

                SqlParameter EmpId = new SqlParameter();
                EmpId.ParameterName = "@EmpId";
                EmpId.Value = RadTextBoxExcedeId.Text;
                EmpId.SqlDbType = SqlDbType.VarChar;
                EmpId.Size = 25;
                EmpId.Direction = ParameterDirection.Input;
                command.Parameters.Add(EmpId);

                SqlParameter Password = new SqlParameter();
                Password.ParameterName = "@Password";
                Password.Value = RadTextBoxExcedePassword.Text;
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
                    RadLabelOutput.Text = "Username or Password is Incorrect";
                }

                if (Validated.Value.ToString() == "1")
                {
                    RadLabelOutput.Text = "Username or Password is Correct"; 
                    Content.Visible = true;
                    wrapper.Visible = false;
                    HiddenFieldEmpId.Value = RadTextBoxExcedeId.Text;
                    HiddenFieldFullName.Value = EmpName.Value.ToString();
                }
            }
        }
    }
}
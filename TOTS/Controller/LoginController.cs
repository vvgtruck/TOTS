using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TOTS.Controller
{
    public class LoginController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        /*
        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }
        */

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]LoginRequest loginRequest)
        {

            LoginResponse loginResponse = new LoginResponse();

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
                EmpId.Value = loginRequest.Username;
                EmpId.SqlDbType = SqlDbType.VarChar;
                EmpId.Size = 25;
                EmpId.Direction = ParameterDirection.Input;
                command.Parameters.Add(EmpId);

                SqlParameter Password = new SqlParameter();
                Password.ParameterName = "@Password";
                Password.Value = loginRequest.Password;
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
                    loginResponse.Error = "Username, Password, or Role is Incorrect";
                    loginResponse.ApiToken = null;
                    loginResponse.EmpName = null;
                }

                if (Validated.Value.ToString() == "1")
                {
                    loginResponse.ApiToken = WspId.Value.ToString();
                    loginResponse.EmpName = EmpName.Value.ToString();
                    loginResponse.Error = null;
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK, loginResponse, Configuration.Formatters.JsonFormatter);
        }


        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }

    public class LoginRequest
    {
        public string Username { get; set; }

        public string Password { get; set; }

    }

    class LoginResponse
    {
        public string ApiToken { get; set; }

        public string EmpName { get; set; }

        public string Error { get; set; }

    }
}
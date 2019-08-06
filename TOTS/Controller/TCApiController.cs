using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;
using TOTS.Model;

namespace TOTS.Controller
{
    public class TCApiController : ApiController
    {
        // GET api/<controller>/<action>
        [Route("api/tcapi/getpayperiod")]
        public HttpResponseMessage GetPayPeriod()
        {

            List<PayPeriod> payPeriods = new List<PayPeriod>();

            string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_SelectPayrollPeriods", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                conn.Open();
                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        //response += rdr["payrollId"] + " : " + rdr["Des"];
                        PayPeriod payPeriod = new PayPeriod();
                        payPeriod.PayPeriodId = Int32.Parse(rdr["payrollId"].ToString());
                        payPeriod.Desc = rdr["des"].ToString();
                        payPeriods.Add(payPeriod);
                    }
                }

                conn.Close();
            }

            return Request.CreateResponse(HttpStatusCode.OK, payPeriods, Configuration.Formatters.JsonFormatter);

        }

        // GET api/<controller>
        [Route("api/tcapi/getdata")]
        public IEnumerable<string> GetData()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        /*public string Get(int id)
        {
            return "value";
        }*/

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
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
   
}
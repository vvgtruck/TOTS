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
    /**
     * Controller to manage TimeClock Api's for Mobile App Access.
     * @package    Controller
     * @author     Satyen Udeshi <satyen@savitriya.com>
     * @since      Class available since Release 1.0
     */
    public class TimeClockController : ApiController
    {

        /**
         * Get PayPeriods to be used in subsequent API Calls.
         *
         * @return PayPeriods list.
         */
        // GET api/<controller>/<action>
        [Route("api/timeclock/getpayperiod")]
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
                    // iterate through results, adding each of them to List<PayPeriod>
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

        /**
         * Get Tech's TimeSheet Calc.
         *
         * @param  PayPeriodId Selected PayPeriod from the Pay Period List
         * @param  EmpId LoggedIn User's EmpId (Dayforce Id)
         * @return TimeSheet Calc Data
         */

        // GET api/<controller>/<action>
        [Route("api/timeclock/techtimesheetcalc")]
        public HttpResponseMessage GetTechTimeSheetCalc([FromUri]string payperiod_id, [FromUri]string emp_id)
        {
            TechTimeSheetCalc techTimeSheetCalc = new TechTimeSheetCalc();

            string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=Excede;UID=sa;PWD=Network9899;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("user_sp_VVGDev_TTS_ServiceTechnicianTimeCalc", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                conn.Open();

                // Add input parameter

                SqlParameter EmpId = new SqlParameter();
                EmpId.ParameterName = "@EmpId";
                EmpId.Value = emp_id;
                EmpId.SqlDbType = SqlDbType.VarChar;
                EmpId.Size = 25;
                EmpId.Direction = ParameterDirection.Input;
                command.Parameters.Add(EmpId);

                SqlParameter PayperiodId = new SqlParameter();
                PayperiodId.ParameterName = "@payrollId";
                PayperiodId.Value = payperiod_id;
                PayperiodId.SqlDbType = SqlDbType.Int;
                PayperiodId.Size = 25;
                PayperiodId.Direction = ParameterDirection.Input;
                command.Parameters.Add(PayperiodId);

                SqlParameter BrnId = new SqlParameter();
                BrnId.ParameterName = "@brnId";
                BrnId.Value = "000";
                BrnId.SqlDbType = SqlDbType.VarChar;
                BrnId.Size = 25;
                BrnId.Direction = ParameterDirection.Input;
                command.Parameters.Add(BrnId);

                SqlParameter TechType = new SqlParameter();
                TechType.ParameterName = "@techtype";
                TechType.Value = 0;
                TechType.SqlDbType = SqlDbType.Int;
                TechType.Size = 25;
                TechType.Direction = ParameterDirection.Input;
                command.Parameters.Add(TechType);

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    // iterate through results, adding each of them to List<PayPeriod>
                    while (rdr.Read())
                    {
                        //response += rdr["payrollId"] + " : " + rdr["Des"];
                        techTimeSheetCalc.EmpId = rdr["EmpId"].ToString();
                        techTimeSheetCalc.Name = rdr["Name"].ToString();
                        techTimeSheetCalc.ShiftId = rdr["ShiftId"].ToString();
                        techTimeSheetCalc.IdleRate = float.Parse(rdr["IdleRate"].ToString());
                        techTimeSheetCalc.ShopRate = float.Parse(rdr["ShopRate"].ToString());
                        techTimeSheetCalc.ApprovedFlag = Int32.Parse(rdr["ApprovedFlag"].ToString());
                        techTimeSheetCalc.LaborGuideActual = float.Parse(rdr["LaborGuideActual"].ToString());
                        techTimeSheetCalc.LaborGuideBill = float.Parse(rdr["LaborGuideBill"].ToString());
                        techTimeSheetCalc.AttendenceWeek1 = float.Parse(rdr["AttendenceWeek1"].ToString());
                        techTimeSheetCalc.AttendenceWeek2 = float.Parse(rdr["AttendenceWeek2"].ToString());
                        techTimeSheetCalc.OvertimeWeek1 = float.Parse(rdr["OvertimeWeek1"].ToString());
                        techTimeSheetCalc.OvertimeWeek2 = float.Parse(rdr["OvertimeWeek2"].ToString());
                        techTimeSheetCalc.DoubletimeWeek1 = float.Parse(rdr["DoubletimeWeek1"].ToString());
                        techTimeSheetCalc.DoubletimeWeek2 = float.Parse(rdr["DoubletimeWeek2"].ToString());
                        techTimeSheetCalc.ShoptimeWeek1 = float.Parse(rdr["ShoptimeWeek1"].ToString());
                        techTimeSheetCalc.ShoptimeWeek2 = float.Parse(rdr["ShoptimeWeek2"].ToString());
                        techTimeSheetCalc.IdletimeWeek1 = float.Parse(rdr["IdletimeWeek1"].ToString());
                        techTimeSheetCalc.IdletimeWeek2 = float.Parse(rdr["IdletimeWeek2"].ToString());
                        techTimeSheetCalc.WeightedRate = float.Parse(rdr["WeightedRate"].ToString());
                        techTimeSheetCalc.ProductionTime = float.Parse(rdr["ProductionTime"].ToString());
                        techTimeSheetCalc.Efficiency = float.Parse(rdr["Efficiency"].ToString());
                        techTimeSheetCalc.Productivity = float.Parse(rdr["Productivity"].ToString());
                        techTimeSheetCalc.IdlePay = float.Parse(rdr["IdlePay"].ToString());
                        techTimeSheetCalc.RegPay = float.Parse(rdr["RegPay"].ToString());
                        techTimeSheetCalc.OvertimePay = float.Parse(rdr["OvertimePay"].ToString());
                        techTimeSheetCalc.DoubletimePay = float.Parse(rdr["DoubletimePay"].ToString());
                        techTimeSheetCalc.ProductionBonus = float.Parse(rdr["ProductionBonus"].ToString());
                        techTimeSheetCalc.PayTotal = float.Parse(rdr["PayTotal"].ToString());
                        
                    }
                }

                conn.Close();
            }
            return Request.CreateResponse(HttpStatusCode.OK, techTimeSheetCalc, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>
        [Route("api/timeclock/getdata")]
        public IEnumerable<string> GetData()
        {
            return new string[] { "value1", "value2" };
        }

 
    }
   
}
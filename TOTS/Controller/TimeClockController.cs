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

    [Authorize]
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

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

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
         * Get Tech's TimeSheet Calc for Dashboard.
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

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=Excede;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=Excede;UID=Raj;PWD=Cascadia1234;";

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
                        //techTimeSheetCalc.EmpId = rdr["EmpId"].ToString();
                        //techTimeSheetCalc.Name = rdr["Name"].ToString();
                        //techTimeSheetCalc.ShiftId = rdr["ShiftId"].ToString();
                        //techTimeSheetCalc.IdleRate = float.Parse(rdr["IdleRate"].ToString());
                        //techTimeSheetCalc.ShopRate = float.Parse(rdr["ShopRate"].ToString());
                        //techTimeSheetCalc.ApprovedFlag = Int32.Parse(rdr["ApprovedFlag"].ToString());
                        techTimeSheetCalc.LaborGuideActual = (float.Parse(rdr["LaborGuideActual"].ToString())) + " Hrs";
                        techTimeSheetCalc.LaborGuideBill = rdr["LaborGuideBill"].ToString() + " Hrs";
                        techTimeSheetCalc.AttendenceWeek = (float.Parse(rdr["AttendenceWeek1"].ToString()) + float.Parse(rdr["AttendenceWeek2"].ToString())) + " Hrs";
                        //techTimeSheetCalc.AttendenceWeek2 = float.Parse(rdr["AttendenceWeek2"].ToString());
                        techTimeSheetCalc.OvertimeWeek = (float.Parse(rdr["OvertimeWeek1"].ToString()) + float.Parse(rdr["OvertimeWeek2"].ToString())) + " Hrs";
                        //techTimeSheetCalc.OvertimeWeek2 = float.Parse(rdr["OvertimeWeek2"].ToString());
                        //techTimeSheetCalc.DoubletimeWeek1 = float.Parse(rdr["DoubletimeWeek1"].ToString());
                        //techTimeSheetCalc.DoubletimeWeek2 = float.Parse(rdr["DoubletimeWeek2"].ToString());
                        //techTimeSheetCalc.ShoptimeWeek1 = float.Parse(rdr["ShoptimeWeek1"].ToString());
                        //techTimeSheetCalc.ShoptimeWeek2 = float.Parse(rdr["ShoptimeWeek2"].ToString());
                        techTimeSheetCalc.IdletimeWeek = (float.Parse(rdr["IdletimeWeek1"].ToString()) + float.Parse(rdr["IdletimeWeek2"].ToString())) + " Hrs";
                        //techTimeSheetCalc.IdletimeWeek2 = float.Parse(rdr["IdletimeWeek2"].ToString());
                        //techTimeSheetCalc.WeightedRate = float.Parse(rdr["WeightedRate"].ToString());
                        techTimeSheetCalc.ProductionTime = rdr["ProductionTime"].ToString() + " Hrs";
                        techTimeSheetCalc.Efficiency = (float.Parse(rdr["Efficiency"].ToString()) * 100) + "%";
                        techTimeSheetCalc.Productivity = (float.Parse(rdr["Productivity"].ToString()) * 100 ) + "%";
                        //techTimeSheetCalc.IdlePay = float.Parse(rdr["IdlePay"].ToString());
                        //techTimeSheetCalc.RegPay = float.Parse(rdr["RegPay"].ToString());
                        //techTimeSheetCalc.OvertimePay = float.Parse(rdr["OvertimePay"].ToString());
                        //techTimeSheetCalc.DoubletimePay = float.Parse(rdr["DoubletimePay"].ToString());
                        //techTimeSheetCalc.ProductionBonus = float.Parse(rdr["ProductionBonus"].ToString());
                        //techTimeSheetCalc.PayTotal = float.Parse(rdr["PayTotal"].ToString());
                        
                    }
                }

                conn.Close();
            }
            return Request.CreateResponse(HttpStatusCode.OK, techTimeSheetCalc, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>/<action>
        [Route("api/timeclock/timesheet/singletech/lunchattendence")]
        public HttpResponseMessage GetSingleTechLunchAttendence([FromUri]string payperiod_id, [FromUri]string emp_id)
        {

            /// Following Code Executes the VVGWebApps_SP_Service_SelectTechTimeSingleTechAttendanceV2 procedure
            /// and returns the Lunch and Attendence entries in the required format.

            LunchAttendance lunchAttendence = new LunchAttendance();

            Dictionary<string, LunchAttendanceEntry> lunchAttendenceEntries = new Dictionary<string, LunchAttendanceEntry>();
            float totalLunchHours = 0;
            float totalAttendenceHours = 0;

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_SelectTechTimeSingleTechAttendanceV2", conn)
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

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    // iterate through results
                    int i = 0;

                    while (rdr.Read())
                    {

                        // Dictionary's Key
                        string weekDay = rdr["Weekday"].ToString();

                        if (lunchAttendenceEntries.Count == 0
                            || !lunchAttendenceEntries.ContainsKey(weekDay))
                        {
                            LunchAttendanceWeekday lunchAttendenceWeekday = new LunchAttendanceWeekday();
                            lunchAttendenceWeekday.Reason = rdr["Reason"].ToString();
                            lunchAttendenceWeekday.InTime = rdr["DateStart"].ToString();
                            lunchAttendenceWeekday.OutTime = rdr["DateEnd"].ToString();

                            if (DBNull.Value.Equals(rdr["PaidTime"]))
                            {
                                lunchAttendenceWeekday.PaidTime = 0;
                            }
                            else
                            {
                                lunchAttendenceWeekday.PaidTime = float.Parse(rdr["PaidTime"].ToString());
                            }

                            if (DBNull.Value.Equals(rdr["NonPaidTime"])) {
                                lunchAttendenceWeekday.NonPaidTime = 0;
                            }
                            else
                            {
                                lunchAttendenceWeekday.NonPaidTime = float.Parse(rdr["NonPaidTime"].ToString());
                            }

                            lunchAttendenceWeekday.Des1 = rdr["Des1"].ToString();

                            List<LunchAttendanceWeekday> lunchAttendenceWeekdays = new List<LunchAttendanceWeekday>();
                            lunchAttendenceWeekdays.Add(lunchAttendenceWeekday);


                            LunchAttendanceEntry lunchAttendenceEntry = new LunchAttendanceEntry();
                            lunchAttendenceEntry.lunchAttendanceWeekdays = lunchAttendenceWeekdays;
                            lunchAttendenceEntry.TAttendenceHours = lunchAttendenceWeekday.PaidTime;
                            lunchAttendenceEntry.TLunchHours = lunchAttendenceWeekday.NonPaidTime;

                            lunchAttendenceEntries.Add(weekDay, lunchAttendenceEntry);
                            totalAttendenceHours += lunchAttendenceEntry.TAttendenceHours;
                            totalLunchHours += lunchAttendenceEntry.TLunchHours;

                        } else if(lunchAttendenceEntries.ContainsKey(weekDay))
                        {
                            LunchAttendanceEntry lunchAttendenceEntry = lunchAttendenceEntries[weekDay];
                            List<LunchAttendanceWeekday> tempLAWeekDays = lunchAttendenceEntry.lunchAttendanceWeekdays;

                            LunchAttendanceWeekday lunchAttendenceWeekday = new LunchAttendanceWeekday();
                            lunchAttendenceWeekday.Reason = rdr["Reason"].ToString();
                            lunchAttendenceWeekday.InTime = rdr["DateStart"].ToString();
                            lunchAttendenceWeekday.OutTime = rdr["DateEnd"].ToString();

                            if (DBNull.Value.Equals(rdr["PaidTime"]))
                            {
                                lunchAttendenceWeekday.PaidTime = 0;
                            }
                            else
                            {
                                lunchAttendenceWeekday.PaidTime = float.Parse(rdr["PaidTime"].ToString());
                            }

                            if (DBNull.Value.Equals(rdr["NonPaidTime"]))
                            {
                                lunchAttendenceWeekday.NonPaidTime = 0;
                            }
                            else
                            {
                                lunchAttendenceWeekday.NonPaidTime = float.Parse(rdr["NonPaidTime"].ToString());
                            }

                            lunchAttendenceWeekday.Des1 = rdr["Des1"].ToString();

                            tempLAWeekDays.Add(lunchAttendenceWeekday);

                            lunchAttendenceEntry.TAttendenceHours += lunchAttendenceWeekday.PaidTime;
                            lunchAttendenceEntry.TLunchHours += lunchAttendenceWeekday.NonPaidTime;

                            totalAttendenceHours += lunchAttendenceWeekday.PaidTime;
                            totalLunchHours += lunchAttendenceWeekday.NonPaidTime;
                        } 

                        i++;
                    }

                    lunchAttendence.lunchAttendanceEntries = lunchAttendenceEntries;
                    lunchAttendence.TAttendanceHours = totalAttendenceHours;
                    lunchAttendence.TLunchHours = totalLunchHours;
                }

                conn.Close();
            }
            
            return Request.CreateResponse(HttpStatusCode.OK, lunchAttendence, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>/<action>
        [Route("api/timeclock/timesheet/singletech/shopfloor")]
        public HttpResponseMessage GetSingleTechShopFloor([FromUri]string payperiod_id, [FromUri]string emp_id)
        {

            /// Following Code Executes the VVGWebApps_SP_Service_SelectTechTimeSingleTechShopFloor procedure
            /// and returns the Shop Floor entries in the required format.

            ShopFloor shopFloor = new ShopFloor();

            Dictionary<string, ShopFloorEntry> shopFloorEntries = new Dictionary<string, ShopFloorEntry>();
            float totalShopFloorHours = 0;

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_SelectTechTimeSingleTechShopFloor", conn)
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

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    // iterate through results
                    int i = 0;

                    while (rdr.Read())
                    {

                        // Dictionary's Key
                        string weekDay = rdr["Weekday"].ToString();

                        if (shopFloorEntries.Count == 0
                            || !shopFloorEntries.ContainsKey(weekDay))
                        {
                            ShopFloorWeekday shopFloorWeekday = new ShopFloorWeekday();
                            shopFloorWeekday.Invoice = rdr["Invoice"].ToString();
                            shopFloorWeekday.CusName = rdr["CusName"].ToString();
                            shopFloorWeekday.Reason = rdr["Reason"].ToString();
                            shopFloorWeekday.InTime = rdr["DateStart"].ToString();
                            shopFloorWeekday.OutTime = rdr["DateEnd"].ToString();

                            if (DBNull.Value.Equals(rdr["Duration"]))
                            {
                                shopFloorWeekday.Duration = 0;
                            }
                            else
                            {
                                shopFloorWeekday.Duration = float.Parse(rdr["Duration"].ToString());
                            }

                            shopFloorWeekday.Des1 = rdr["Des1"].ToString();

                            List<ShopFloorWeekday> shopFloorWeekdays = new List<ShopFloorWeekday>();
                            shopFloorWeekdays.Add(shopFloorWeekday);


                            ShopFloorEntry shopFloorEntry = new ShopFloorEntry();
                            shopFloorEntry.shopFloorWeekdays = shopFloorWeekdays;
                            shopFloorEntry.TShopFloorHours = shopFloorWeekday.Duration;

                            shopFloorEntries.Add(weekDay, shopFloorEntry);
                            totalShopFloorHours += shopFloorEntry.TShopFloorHours;

                        }
                        else if (shopFloorEntries.ContainsKey(weekDay))
                        {
                            ShopFloorEntry shopFloorEntry = shopFloorEntries[weekDay];
                            List<ShopFloorWeekday> tempSWeekDays = shopFloorEntry.shopFloorWeekdays;

                            ShopFloorWeekday shopFloorWeekday = new ShopFloorWeekday();
                            shopFloorWeekday.Reason = rdr["Reason"].ToString();
                            shopFloorWeekday.InTime = rdr["DateStart"].ToString();
                            shopFloorWeekday.OutTime = rdr["DateEnd"].ToString();

                            if (DBNull.Value.Equals(rdr["Duration"]))
                            {
                                shopFloorWeekday.Duration = 0;
                            }
                            else
                            {
                                shopFloorWeekday.Duration = float.Parse(rdr["Duration"].ToString());
                            }

                            shopFloorWeekday.Des1 = rdr["Des1"].ToString();

                            tempSWeekDays.Add(shopFloorWeekday);

                            shopFloorEntry.TShopFloorHours += shopFloorWeekday.Duration;

                            totalShopFloorHours += shopFloorWeekday.Duration;
                        }

                        i++;
                    }

                    shopFloor.shopFloorEntries = shopFloorEntries;
                    shopFloor.TShopFloorHours = totalShopFloorHours;
                }

                conn.Close();
            }

            return Request.CreateResponse(HttpStatusCode.OK, shopFloor, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>/<action>
        [Route("api/timeclock/work/productionbonus")]
        public HttpResponseMessage GetTechWorkProductionBonus([FromUri]string payperiod_id, [FromUri]string emp_id)
        {

            List<WorkProductionBonus> workProductionBonuses = new List<WorkProductionBonus>();

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_SelectTechTimeSingleTechProdBonus", conn)
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

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    int i = 0;

                    while(rdr.Read())
                    {
                        WorkProductionBonus workProductionBonus = new WorkProductionBonus();
                        workProductionBonus.Type = rdr["Type"].ToString();
                        string dateInvoice = rdr["DateInvoice"].ToString();

                        if(dateInvoice.Equals(""))
                        {
                            workProductionBonus.DateInvoice = "";
                        }
                        else
                        {
                            DateTime _date = DateTime.Parse(dateInvoice);
                            string _dateInFormat = _date.ToString("MM/dd/yyyy");
                            workProductionBonus.DateInvoice = _dateInFormat;
                        }
                        workProductionBonus.SlsId = rdr["SlsId"].ToString();
                        workProductionBonus.OpsId = Int32.Parse(rdr["OpsId"].ToString());
                        workProductionBonus.CusName = rdr["CusName"].ToString();
                        workProductionBonus.SvItm = rdr["SvItm"].ToString();
                        workProductionBonus.Des = rdr["Des"].ToString();
                        workProductionBonus.HrsBill = float.Parse(rdr["HrsBill"].ToString());
                        workProductionBonus.HrsActual = float.Parse(rdr["HrsActual"].ToString());
                        workProductionBonus.Difference = float.Parse(rdr["Difference"].ToString());

                        workProductionBonuses.Add(workProductionBonus);
                    }
                }

                conn.Close();
            }

            return Request.CreateResponse(HttpStatusCode.OK, workProductionBonuses, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>/<action>
        [Route("api/timeclock/timeapproval")]
        public HttpResponseMessage GetTimeApprovalList([FromUri]string payperiod_id, [FromUri]string emp_id)
        {

            List<TimeApproval> timeApprovals = new List<TimeApproval>();

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_SelectTechTimeSingleTechApprovalV2", conn)
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

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    int i = 0;

                    while (rdr.Read())
                    {
                        TimeApproval timeApproval = new TimeApproval();
                        timeApproval.Weekday = rdr["Weekday"].ToString();
                        timeApproval.Lunch = float.Parse(rdr["Lunch"].ToString());
                        timeApproval.Attendance = float.Parse(rdr["Attendence"].ToString());
                        timeApproval.Shop = float.Parse(rdr["Shop"].ToString());
                        timeApproval.Approval = rdr["Approval"].ToString();
                        
                        timeApprovals.Add(timeApproval);
                    }
                }

                conn.Close();
            }

            return Request.CreateResponse(HttpStatusCode.OK, timeApprovals, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>/<action>
        [Route("api/timeclock/lunchviolation")]
        public HttpResponseMessage GetLunchViolationList([FromUri]string payperiod_id, [FromUri]string emp_id)
        {

            List<LunchViolation> timeApprovals = new List<LunchViolation>();

            //string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";
            string connectionString = "Data Source=68.14.228.213,14433\\SQLEXPRESS,1433;Initial Catalog=VVGWebApps;UID=Raj;PWD=Cascadia1234;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_SP_Service_LunchViolations_byEmp", conn)
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

                // execute the command
                using (SqlDataReader rdr = command.ExecuteReader())
                {
                    int i = 0;

                    while (rdr.Read())
                    {
                        LunchViolation lunchViolation = new LunchViolation();
                        lunchViolation.Violation = rdr["Violation"].ToString();
                        lunchViolation.ShiftStart = rdr["ShiftStart"].ToString();
                        lunchViolation.ShiftEnd = rdr["ShiftEnd"].ToString();
                        lunchViolation.Acknowledge = rdr["Acknowledge"].ToString();
                        lunchViolation.Waiver = rdr["Waiver"].ToString();
                        lunchViolation.WaiverSigned = rdr["WaiverSigned"].ToString();
                        lunchViolation.WaiverRevoke = rdr["WaiverRevoke"].ToString();
                        lunchViolation.WaiverComplete = rdr["WaiverComplete"].ToString();

                        timeApprovals.Add(lunchViolation);
                    }
                }

                conn.Close();
            }

            return Request.CreateResponse(HttpStatusCode.OK, timeApprovals, Configuration.Formatters.JsonFormatter);
        }

        // GET api/<controller>
        [Route("api/timeclock/getdata")]
        public IEnumerable<string> GetData()
        {
            return new string[] { "value1", "value2" };
        }

 
    }
   
}
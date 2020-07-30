using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class TechTimeSheetCalc
    {
        [JsonIgnore]
        public string EmpId { get; set; }

        [JsonIgnore]
        public string Name { get; set; }

        [JsonIgnore]
        public string ShiftId { get; set; }

        [JsonIgnore]
        public float IdleRate { get; set; }

        [JsonIgnore]
        public float ShopRate { get; set; }

        [JsonIgnore]
        public int ApprovedFlag { get; set; }

        public String LaborGuideBill { get; set; }

        public String LaborGuideActual { get; set; }

        public String Efficiency { get; set; }

        public String Productivity { get; set; }

        public String ProductionTime { get; set; }

        public String AttendenceWeek { get; set; }

        //public float AttendenceWeek2 { get; set; }

        public String OvertimeWeek { get; set; }

        //public float OvertimeWeek2 { get; set; }

        [JsonIgnore]
        public float DoubletimeWeek1 { get; set; }

        [JsonIgnore]
        public float DoubletimeWeek2 { get; set; }

        [JsonIgnore]
        public float ShoptimeWeek1 { get; set; }

        [JsonIgnore]
        public float ShoptimeWeek2 { get; set; }

        public String IdletimeWeek { get; set; }

        //public float IdletimeWeek2 { get; set; }

        [JsonIgnore]
        public float WeightedRate { get; set; }

        [JsonIgnore]
        public float IdlePay { get; set; }

        [JsonIgnore]
        public float RegPay { get; set; }

        [JsonIgnore]
        public float OvertimePay { get; set; }

        [JsonIgnore]
        public float DoubletimePay { get; set; }

        [JsonIgnore]
        public float ProductionBonus { get; set; }

        [JsonIgnore]
        public float PayTotal { get; set; }

    }
}
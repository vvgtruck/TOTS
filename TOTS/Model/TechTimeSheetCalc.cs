using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class TechTimeSheetCalc
    {

        public string EmpId { get; set; }

        public string Name { get; set; }

        public string ShiftId { get; set; }

        public float IdleRate { get; set; }

        public float ShopRate { get; set; }

        public int ApprovedFlag { get; set; }

        public float LaborGuideActual { get; set; }

        public float LaborGuideBill { get; set; }

        public float AttendenceWeek1 { get; set; }

        public float AttendenceWeek2 { get; set; }

        public float OvertimeWeek1 { get; set; }

        public float OvertimeWeek2 { get; set; }

        public float DoubletimeWeek1 { get; set; }

        public float DoubletimeWeek2 { get; set; }

        public float ShoptimeWeek1 { get; set; }

        public float ShoptimeWeek2 { get; set; }

        public float IdletimeWeek1 { get; set; }

        public float IdletimeWeek2 { get; set; }

        public float WeightedRate { get; set; }

        public float ProductionTime { get; set; }

        public float Efficiency { get; set; }

        public float Productivity { get; set; }

        public float IdlePay { get; set; }

        public float RegPay { get; set; }

        public float OvertimePay { get; set; }

        public float DoubletimePay { get; set; }

        public float ProductionBonus { get; set; }

        public float PayTotal { get; set; }





    }
}
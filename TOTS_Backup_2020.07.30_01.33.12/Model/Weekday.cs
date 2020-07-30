using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class Weekday
    {
        // Possible Values = Lunch, Attendence, Shop-Floor
        public String Des1 { get; set; }

        public string InTime { get; set; }

        public string OutTime { get; set; }

        public string Reason { get; set; }
    }
}
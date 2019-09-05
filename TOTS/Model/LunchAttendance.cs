using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchAttendance
    {

        public Dictionary<string, LunchAttendanceEntry> lunchAttendanceEntries { get; set; }

        public float TLunchHours { get; set; }

        public float TAttendanceHours { get; set; }

    }
}
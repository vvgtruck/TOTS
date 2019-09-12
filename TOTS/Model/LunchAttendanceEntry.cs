using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchAttendanceEntry : WeekdayEntry
    {
        public List<LunchAttendanceWeekday> lunchAttendanceWeekdays { get; set; }

        public float TLunchHours { get; set; }

        public float TAttendenceHours { get; set; }

    }
}
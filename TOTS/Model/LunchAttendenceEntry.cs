using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchAttendenceEntry : WeekdayEntry
    {
        public List<LunchAttendenceWeekday> lunchAttendenceWeekdays { get; set; }

        public float TLunchHours { get; set; }

        public float TAttendenceHours { get; set; }

    }
}
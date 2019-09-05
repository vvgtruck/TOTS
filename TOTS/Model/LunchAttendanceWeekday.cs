using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchAttendanceWeekday : Weekday
    {
        public float PaidTime { get; set; }

        public float NonPaidTime { get; set; }

    }
}
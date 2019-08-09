using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchAttendence
    {

        public Dictionary<string, LunchAttendenceEntry> lunchAttendenceEntries { get; set; }

        public float TLunchHours { get; set; }

        public float TAttendenceHours { get; set; }

    }
}
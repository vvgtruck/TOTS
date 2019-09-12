using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class LunchViolation
    {

        public string Violation { get; set; }

        public string ShiftStart { get; set; }

        public string ShiftEnd { get; set; }

        public string Acknowledge { get; set; }

        public string Waiver { get; set; }

        public string WaiverSigned { get; set; }

        public string WaiverRevoke { get; set; }

        public string WaiverComplete { get; set; }

    }
}
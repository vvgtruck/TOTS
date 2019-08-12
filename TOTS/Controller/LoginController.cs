﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace TOTS.Controller
{
    public class LoginController : ApiController
    {
       
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]LoginRequest loginRequest)
        {

            LoginResponse loginResponse = new LoginResponse();

            string connectionString = "Data Source=VVGSVDMS001.Velocity.Company;Initial Catalog=VVGWebApps;UID=sa;PWD=Network9899;";

            using (var conn = new SqlConnection(connectionString))
            using (var command = new SqlCommand("VVGWebApps_TOTSSingleLogin_Validate", conn)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                conn.Open();

                // Add input parameter

                SqlParameter EmpId = new SqlParameter();
                EmpId.ParameterName = "@EmpId";
                EmpId.Value = loginRequest.Username;
                EmpId.SqlDbType = SqlDbType.VarChar;
                EmpId.Size = 25;
                EmpId.Direction = ParameterDirection.Input;
                command.Parameters.Add(EmpId);

                SqlParameter Password = new SqlParameter();
                Password.ParameterName = "@Password";
                Password.Value = loginRequest.Password;
                Password.SqlDbType = SqlDbType.VarChar;
                Password.Size = 25;
                Password.Direction = ParameterDirection.Input;
                command.Parameters.Add(Password);

                // Add output parameters

                SqlParameter Validated = new SqlParameter();
                Validated.ParameterName = "@Validated";
                Validated.SqlDbType = SqlDbType.Int;
                Validated.Direction = ParameterDirection.Output;
                command.Parameters.Add(Validated);

                SqlParameter WspId = new SqlParameter();
                WspId.ParameterName = "@WspId";
                WspId.SqlDbType = SqlDbType.Int;
                WspId.Direction = ParameterDirection.Output;
                command.Parameters.Add(WspId);

                SqlParameter EmpName = new SqlParameter();
                EmpName.ParameterName = "@EmpName";
                EmpName.SqlDbType = SqlDbType.VarChar;
                EmpName.Size = 50;
                EmpName.Direction = ParameterDirection.Output;
                command.Parameters.Add(EmpName);

                //execute
                command.ExecuteNonQuery();

                conn.Close();
                conn.Dispose();

                if (Validated.Value.ToString() == "0")
                {
                    loginResponse.Error = "Username, Password, or Role is Incorrect";
                    loginResponse.ApiToken = null;
                    loginResponse.EmpName = null;
                }

                if (Validated.Value.ToString() == "1")
                {
                    loginResponse.ApiToken = createToken(loginRequest.Username); ;
                    loginResponse.EmpName = EmpName.Value.ToString();
                    loginResponse.Error = null;
                }
            }
            return Request.CreateResponse(HttpStatusCode.OK, loginResponse, Configuration.Formatters.JsonFormatter);
        }


        private string createToken(string username)
        {
            //Set issued at date
            DateTime issuedAt = DateTime.UtcNow;
            //set the time when it expires
            DateTime expires = DateTime.UtcNow.AddDays(7);

            //http://stackoverflow.com/questions/18223868/how-to-encrypt-jwt-security-token
            var tokenHandler = new JwtSecurityTokenHandler();

            //create a identity and add claims to the user which we want to log in
            ClaimsIdentity claimsIdentity = new ClaimsIdentity(new[]
            {
                new Claim(ClaimTypes.Name, username)
            });

            const string sec = "401b09eab3c013d4ca54922bb802bec8fd5318192b0a75f201d8b3727429090fb337591abd3e44453b954555b7a0812e1081c39b740293f765eae731f5a65ed1";
            var now = DateTime.UtcNow;
            var securityKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(System.Text.Encoding.Default.GetBytes(sec));
            var signingCredentials = new Microsoft.IdentityModel.Tokens.SigningCredentials(securityKey, Microsoft.IdentityModel.Tokens.SecurityAlgorithms.HmacSha256Signature);


            //create the jwt
            var token =
                (JwtSecurityToken)
                    tokenHandler.CreateJwtSecurityToken(issuer: "http://localhost:61299", audience: "http://localhost:61299",
                        subject: claimsIdentity, notBefore: issuedAt, expires: expires, signingCredentials: signingCredentials);
            var tokenString = tokenHandler.WriteToken(token);

            return tokenString;
        }

    }

    public class LoginRequest
    {
        public string Username { get; set; }

        public string Password { get; set; }

    }

    class LoginResponse
    {
        public string ApiToken { get; set; }

        public string EmpName { get; set; }

        public string Error { get; set; }

    }
}
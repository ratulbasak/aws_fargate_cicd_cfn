﻿﻿using System;

using System.Collections;

using System.Collections.Generic;

using System.IO;

using System.Linq;

using System.Threading.Tasks;

using Microsoft.AspNetCore.Mvc;

using Microsoft.Extensions.Configuration;



namespace WebApplication1.Controllers

{

    [Route("api/[controller]")]

    public class MamaController : Controller

    {

        // GET api/values

        [HttpGet]

        public IEnumerable<string> Get()

        {
            var builder = new ConfigurationBuilder()

            .SetBasePath(Directory.GetCurrentDirectory())

            .AddJsonFile("appsettings.json");





            return new string[] { "blue4444", "green4444"};

        }



        // GET api/values/5

        [HttpGet("{id}")]

        public string Get(int id)

        {

            return "value";

        }



        // POST api/values

        [HttpPost]

        public void Post([FromBody]string value)

        {

        }



        // PUT api/values/5

        [HttpPut("{id}")]

        public void Put(int id, [FromBody]string value)

        {

        }



        // DELETE api/values/5

        [HttpDelete("{id}")]

        public void Delete(int id)

        {

        }

    }

}

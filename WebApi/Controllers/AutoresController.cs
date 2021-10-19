using Dal;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class AutoresController : ApiController
    {
        private static readonly IDao<Autores> dao = DaoAutor.ObtenerDao();

        // GET: api/Autores
        public IEnumerable<Autores> Get()
        {
            return dao.ObtenerTodos();
        }

        // GET: api/Autores/5
        public IHttpActionResult Get(long id)
        {
            Autores autor = dao.ObtenerPorId(id);
            if(autor == null)
            {
                return NotFound();
            }
            return Ok(autor);
        }

        // POST: api/Autores
        public IHttpActionResult Post([FromBody]Autores autor)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Content(HttpStatusCode.Created, dao.Insertar(autor));
        }

        // PUT: api/Autores/5
        public IHttpActionResult Put(int id, [FromBody]Autores autor)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (id != autor.Id)
            {
                return BadRequest();
            }
            autor = dao.Modificar(autor);
            return Ok(autor);
        }

        // DELETE: api/Autores/5
        public IHttpActionResult Delete(int id)
        {
            Autores autor = dao.ObtenerPorId(id);
            if(autor == null)
            {
                return NotFound();
            }
            dao.Borrar(id);
            return StatusCode(HttpStatusCode.NoContent);
        }
    }
}
